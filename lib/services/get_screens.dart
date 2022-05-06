// To parse this JSON data, do
//
//     final getScreens = getScreensFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetScreens getScreensFromJson(String str) => GetScreens.fromJson(json.decode(str));

String getScreensToJson(GetScreens data) => json.encode(data.toJson());

class GetScreens {
  GetScreens({
    required this.error,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.response,
  });

  bool error;
  int statusCode;
  String status;
  dynamic message;
  Response response;

  factory GetScreens.fromJson(Map<String, dynamic> json) => GetScreens(
    error: json["error"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "response": response.toJson(),
  };
}

class Response {
  Response({
    required this.screens,
  });

  List<ResponseScreens> screens;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    screens: List<ResponseScreens>.from(json["screens"].map((x) => ResponseScreens.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "screens": List<dynamic>.from(screens.map((x) => x.toJson())),
  };
}

class ResponseScreens {
  ResponseScreens({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.isOccupied,
    required this.isDefault,
    required this.customerId,
    required this.updatedAt,
    required this.createdAt,
    required this.deviceId,
     this.response,
  });

  String id;
  String name;
  String profileImage;
  int isOccupied;
  int isDefault;
  int customerId;
  DateTime updatedAt;
  DateTime createdAt;
  String deviceId;
  String? response;

  userScreensResponseDataMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['response'] = response ?? "";
    return mapping;
  }

  factory ResponseScreens.fromJson(Map<String, dynamic> json) => ResponseScreens(
    id: json["_id"],
    name: json["name"],
    profileImage: json["profile_image"] ?? "",
    isOccupied: json["is_occupied"],
    isDefault: json["is_default"],
    customerId: json["customer_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    deviceId: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profile_image": profileImage,
    "is_occupied": isOccupied,
    "is_default": isDefault,
    "customer_id": customerId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "device_id": deviceId,
  };
}
