// To parse this JSON data, do
//
//     final distributerDataResponse = distributerDataResponseFromJson(jsonString);

import 'dart:convert';

DistributerDataResponse distributerDataResponseFromJson(String str) => DistributerDataResponse.fromJson(json.decode(str));

String distributerDataResponseToJson(DistributerDataResponse data) => json.encode(data.toJson());

class DistributerDataResponse {
  Settings settings;
  List<Message> message;

  DistributerDataResponse({
    required this.settings,
    required this.message,
  });

  factory DistributerDataResponse.fromJson(Map<String, dynamic> json) => DistributerDataResponse(
    settings: Settings.fromJson(json["settings"]),
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "settings": settings.toJson(),
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
  };
}

class Message {
  String distributorId;
  String customerName;
  String companyId;
  String factoryId;
  String mobileNo;
  String password;
  String role;
  String mobileOtp;

  Message({
    required this.distributorId,
    required this.customerName,
    required this.companyId,
    required this.factoryId,
    required this.mobileNo,
    required this.password,
    required this.role,
    required this.mobileOtp,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    distributorId: json["Distributor_ID"],
    customerName: json["Customer_Name"],
    companyId: json["Company_Id"],
    factoryId: json["Factory_Id"],
    mobileNo: json["Mobile_No"],
    password: json["PASSWORD"],
    role: json["ROLE"],
    mobileOtp: json["MOBILE_OTP"],
  );

  Map<String, dynamic> toJson() => {
    "Distributor_ID": distributorId,
    "Customer_Name": customerName,
    "Company_Id": companyId,
    "Factory_Id": factoryId,
    "Mobile_No": mobileNo,
    "PASSWORD": password,
    "ROLE": role,
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
