import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdi_dost/core/constants/api_constants.dart';
import 'package:pdi_dost/core/widgets/app_text_field.dart';
import 'package:pdi_dost/core/widgets/form_validation_helper.dart';
import 'package:pdi_dost/features/auth/bloc/auth/auth_bloc.dart';
import 'package:pdi_dost/features/auth/model/CitiesModel.dart';
import 'package:pdi_dost/features/auth/model/CountryModel.dart';
import 'package:pdi_dost/features/auth/model/StatesModel.dart';

class CjRequestController extends ChangeNotifier {
  final AuthBloc authBloc;
  final formKey = GlobalKey<FormState>();

  CjRequestController({required this.authBloc});

  // Form Fields
  final name = FieldController();
  final email = FieldController();
  final contactNo = FieldController();
  final experience = FieldController();
  final address = FieldController();
  final idNo = FieldController();
  final country = FieldController();
  final state = FieldController();
  final city = FieldController();

  // Selection Fields
  String? selectedPlatform = 'app';
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String selectedIdentity = "PAN Card"; // Default

  // Location Data
  List<CountryData> countries = [];
  List<StatesData> states = [];
  List<CitiesData> cities = [];

  bool isLoadingCountries = false;
  bool isLoadingStates = false;
  bool isLoadingCities = false;

  // Selection IDs
  String? countryId;
  String? stateId;
  String? cityId;

  // File Paths
  String? resumePath;
  String? identityImagePath;
  String? cancelCheckPath;

  bool isFormValid = false;

  Future<void> fetchCountries() async {
    isLoadingCountries = true;
    notifyListeners();
    try {
      final response = await authBloc.httpClient.get(ApiConstants.countries);
      if (response != null && response['status'] == true) {
        countries = CountryModel.fromJson(response).data;
      }
    } catch (e) {
      debugPrint("Error fetching countries: $e");
    } finally {
      isLoadingCountries = false;
      notifyListeners();
    }
  }

  Future<void> fetchStates(int countryId) async {
    isLoadingStates = true;
    notifyListeners();
    try {
      final response = await authBloc.httpClient.post(ApiConstants.states, {
        "country_id": countryId,
      });
      if (response != null && response['status'] == true) {
        states = StatesModel.fromJson(response).data;
      }
    } catch (e) {
      debugPrint("Error fetching states: $e");
    } finally {
      isLoadingStates = false;
      notifyListeners();
    }
  }

  Future<void> fetchCities(int countryId, int stateId) async {
    isLoadingCities = true;
    notifyListeners();
    try {
      final response = await authBloc.httpClient.post(ApiConstants.cities, {
        "country_id": countryId,
        "state_id": stateId,
      });
      if (response != null && response['status'] == true) {
        cities = CitiesModel.fromJson(response).data;
      }
    } catch (e) {
      debugPrint("Error fetching cities: $e");
    } finally {
      isLoadingCities = false;
      notifyListeners();
    }
  }

  void validateForm() {
    final isNameValid = FormValidators.required(name.text.text) == null;
    final isEmailValid = FormValidators.email(email.text.text) == null;
    final isContactValid =
        FormValidators.phone(contactNo.text.text, length: 10) == null;
    final isExpValid = FormValidators.number(experience.text.text) == null;
    final isAddressValid = FormValidators.required(address.text.text) == null;
    final isIdNoValid = FormValidators.required(idNo.text.text) == null;

    final hasLocations = countryId != null && stateId != null && cityId != null;
    final hasFiles = resumePath != null && identityImagePath != null;

    final isValid =
        isNameValid &&
        isEmailValid &&
        isContactValid &&
        isExpValid &&
        isAddressValid &&
        isIdNoValid &&
        hasLocations &&
        hasFiles;

    if (isFormValid != isValid) {
      isFormValid = isValid;
      notifyListeners();
    }
  }

  void updateIdentity(String value) {
    selectedIdentity = value;
    idNo.text.clear();
    identityImagePath = null;
    validateForm();
    notifyListeners();
  }

  void updatePlatform(String? value) {
    selectedPlatform = value;
    validateForm();
    notifyListeners();
  }

  Future<void> updateCountry(String? value) async {
    if (selectedCountry == value) return;
    selectedCountry = value;
    country.text.text = value ?? "";

    final selected = countries.firstWhere((c) => c.name == value);
    countryId = selected.id.toString();

    // Reset dependents
    selectedState = null;
    state.text.clear();
    stateId = null;
    states = [];

    selectedCity = null;
    city.text.clear();
    cityId = null;
    cities = [];

    await fetchStates(selected.id);
    validateForm();
    notifyListeners();
  }

  Future<void> updateState(String? value) async {
    if (selectedState == value) return;
    selectedState = value;
    state.text.text = value ?? "";

    final selected = states.firstWhere((s) => s.name == value);
    stateId = selected.id.toString();

    // Reset dependents
    selectedCity = null;
    city.text.clear();
    cityId = null;
    cities = [];

    if (countryId != null) {
      await fetchCities(int.parse(countryId!), selected.id);
    }

    validateForm();
    notifyListeners();
  }

  void updateCity(String? value) {
    selectedCity = value;
    city.text.text = value ?? "";

    final selected = cities.firstWhere((c) => c.city == value);
    cityId = selected.id.toString();

    validateForm();
    notifyListeners();
  }

  Future<void> pickFile(String type, ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      if (type == 'resume') {
        resumePath = image.path;
      } else if (type == 'identity') {
        identityImagePath = image.path;
      } else if (type == 'cancelCheck') {
        cancelCheckPath = image.path;
      }
      validateForm();
      notifyListeners();
    }
  }

  void onSubmit() {
    if (isFormValid) {
      final fields = {
        'name': name.text.text,
        'email_id': email.text.text,
        'contact_no': contactNo.text.text,
        'platform': selectedPlatform ?? 'app',
        'country_id': countryId ?? '',
        'state_id': stateId ?? '',
        'city_id': cityId ?? '',
        'experience': experience.text.text,
        'aadhaar_card_no': idNo.text.text,
        'address': address.text.text,
      };

      final filePaths = {
        'resume': resumePath ?? '',
        'aadhaar_image': identityImagePath ?? '',
        if (cancelCheckPath != null) 'cancel_check_image': cancelCheckPath!,
      };

      authBloc.add(CjRequestSubmitted(fields: fields, filePaths: filePaths));
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    contactNo.dispose();
    experience.dispose();
    address.dispose();
    idNo.dispose();
    country.dispose();
    state.dispose();
    city.dispose();
    super.dispose();
  }
}
