import 'dart:convert';

CjRequestModel cjRequestModelFromJson(String str) =>
    CjRequestModel.fromJson(json.decode(str));

String cjRequestModelToJson(CjRequestModel data) => json.encode(data.toJson());

class CjRequestModel {
  bool status;
  String message;
  CjRequestData data;

  CjRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CjRequestModel.fromJson(Map<String, dynamic> json) => CjRequestModel(
    status: json["status"],
    message: json["message"],
    data: CjRequestData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class CjRequestData {
  String name;
  String emailId;
  String contactNo;
  String platform;
  String countryId;
  String stateId;
  String cityId;
  String experience;
  String aadhaarCardNo;
  String address;
  String resume;
  String aadhaarImage;
  String cancelCheckImage;
  bool isApproved;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  CjRequestData({
    required this.name,
    required this.emailId,
    required this.contactNo,
    required this.platform,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.experience,
    required this.aadhaarCardNo,
    required this.address,
    required this.resume,
    required this.aadhaarImage,
    required this.cancelCheckImage,
    required this.isApproved,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory CjRequestData.fromJson(Map<String, dynamic> json) => CjRequestData(
    name: json["name"] ?? '',
    emailId: json["email_id"] ?? '',
    contactNo: json["contact_no"] ?? '',
    platform: json["platform"] ?? '',
    countryId: json["country_id"] ?? '',
    stateId: json["state_id"] ?? '1',
    cityId: json["city_id"] ?? '',
    experience: json["experience"] ?? '',
    aadhaarCardNo: json["aadhaar_card_no"] ?? '',
    address: json["address"] ?? '',
    resume: json["resume"] ?? '',
    aadhaarImage: json["aadhaar_image"] ?? '',
    cancelCheckImage: json["cancel_check_image"] ?? '',
    isApproved: json["is_approved"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email_id": emailId,
    "contact_no": contactNo,
    "platform": platform,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "experience": experience,
    "aadhaar_card_no": aadhaarCardNo,
    "address": address,
    "resume": resume,
    "aadhaar_image": aadhaarImage,
    "cancel_check_image": cancelCheckImage,
    "is_approved": isApproved,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
