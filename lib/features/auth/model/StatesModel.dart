import 'dart:convert';

StatesModel statesModelFromJson(String str) =>
    StatesModel.fromJson(json.decode(str));

String statesModelToJson(StatesModel data) => json.encode(data.toJson());

class StatesModel {
  bool status;
  String message;
  List<StatesData> data;

  StatesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StatesModel.fromJson(Map<String, dynamic> json) => StatesModel(
    status: json["status"],
    message: json["message"],
    data: List<StatesData>.from(
      json["data"].map((x) => StatesData.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StatesData {
  int id;
  String name;
  int countryId;

  StatesData({required this.id, required this.name, required this.countryId});

  factory StatesData.fromJson(Map<String, dynamic> json) => StatesData(
    id: json["id"],
    name: json["name"] ?? '',
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
  };
}
