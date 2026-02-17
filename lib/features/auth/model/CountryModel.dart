import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  bool status;
  String message;
  List<CountryData> data;

  CountryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    status: json["status"],
    message: json["message"] ?? '',
    data: List<CountryData>.from(
      json["data"].map((x) => CountryData.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CountryData {
  int id;
  String countryCode;
  String name;

  CountryData({
    required this.id,
    required this.countryCode,
    required this.name,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["id"],
    countryCode: json["countryCode"] ?? '',
    name: json["name"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countryCode": countryCode,
    "name": name,
  };
}
