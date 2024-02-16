// To parse this JSON data, do
//
//     final posyncResponse = posyncResponseFromJson(jsonString);

import 'dart:convert';

PosyncResponse posyncResponseFromJson(String str) => PosyncResponse.fromJson(json.decode(str));

String posyncResponseToJson(PosyncResponse data) => json.encode(data.toJson());

class PosyncResponse {
  Settings settings;
  String message;

  PosyncResponse({
    required this.settings,
    required this.message,
  });

  factory PosyncResponse.fromJson(Map<String, dynamic> json) => PosyncResponse(
    settings: Settings.fromJson(json["settings"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "settings": settings.toJson(),
    "message": message,
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
