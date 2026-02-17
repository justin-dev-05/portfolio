import 'dart:convert';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  bool status;
  String message;
  List<CitiesData> data;

  CitiesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
    status: json["status"],
    message: json["message"],
    data: List<CitiesData>.from(
      json["data"].map((x) => CitiesData.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CitiesData {
  int id;
  String city;
  int stateId;

  CitiesData({required this.id, required this.city, required this.stateId});

  factory CitiesData.fromJson(Map<String, dynamic> json) => CitiesData(
    id: json["id"],
    city: json["city"] ?? '',
    stateId: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "state_id": stateId,
  };
}
