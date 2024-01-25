// To parse this JSON data, do
//
//     final otpVerificationResponse = otpVerificationResponseFromJson(jsonString);

import 'dart:convert';

OtpVerificationResponse otpVerificationResponseFromJson(String str) => OtpVerificationResponse.fromJson(json.decode(str));

String otpVerificationResponseToJson(OtpVerificationResponse data) => json.encode(data.toJson());

class OtpVerificationResponse {
  Settings settings;
  List<Message> message;

  OtpVerificationResponse({
    required this.settings,
    required this.message,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) => OtpVerificationResponse(
    settings: Settings.fromJson(json["settings"]),
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "settings": settings.toJson(),
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
  };
}

class Message {
  String distributorName;
  String distributorId;
  String companyId;
  String companyName;
  String factoryId;
  String factoryName;
  String businessName;
  String companyGst;
  String companyPan;
  String companyStateCode;
  String role;
  String accessToken;
  String moAccessToken;
  String mobileOtp;

  Message({
    required this.distributorName,
    required this.distributorId,
    required this.companyId,
    required this.companyName,
    required this.factoryId,
    required this.factoryName,
    required this.businessName,
    required this.companyGst,
    required this.companyPan,
    required this.companyStateCode,
    required this.role,
    required this.accessToken,
    required this.moAccessToken,
    required this.mobileOtp,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    distributorName: json["Distributor_name"],
    distributorId: json["Distributor_id"],
    companyId: json["Company_id"],
    companyName: json["Company_name"],
    factoryId: json["Factory_id"],
    factoryName: json["Factory_name"],
    businessName: json["Business_name"],
    companyGst: json["Company_GST"],
    companyPan: json["Company_PAN"],
    companyStateCode: json["Company_state_code"],
    role: json["Role"],
    accessToken: json["Access_token"],
    moAccessToken: json["Mo_Access_Token"],
    mobileOtp: json["MOBILE_OTP"],
  );

  Map<String, dynamic> toJson() => {
    "Distributor_name": distributorName,
    "Distributor_id": distributorId,
    "Company_id": companyId,
    "Company_name": companyName,
    "Factory_id": factoryId,
    "Factory_name": factoryName,
    "Business_name": businessName,
    "Company_GST": companyGst,
    "Company_PAN": companyPan,
    "Company_state_code": companyStateCode,
    "Role": role,
    "Access_token": accessToken,
    "Mo_Access_Token": moAccessToken,
    "MOBILE_OTP": mobileOtp,
  };
}

class Settings {
  String success;

  Settings({
    required this.success,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}
