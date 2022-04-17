// To parse this JSON data, do
//
//     final getUser = getUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetUser getUserFromJson(String str) => GetUser.fromJson(json.decode(str));

String getUserToJson(GetUser data) => json.encode(data.toJson());

class GetUser {
  GetUser({
    required this.error,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.response,
    required this.deviceRestrictionType,
  });

  bool error;
  int statusCode;
  String status;
  String message;
  ResponseData response;
  String deviceRestrictionType;

  factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
    error: json["error"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    response: ResponseData.fromJson(json["response"]),
    deviceRestrictionType: json["device_restriction_type"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "response": response.toJson(),
    "device_restriction_type": deviceRestrictionType,
  };
}

class ResponseData {
  ResponseData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.age,
    required this.profilePicture,
    required this.loginType,
    required this.isLocked,
    required this.notifyEmail,
    required this.countryCode,
    required this.iso,
    required this.customerPaymentId,
    required this.subscriptionType,
    required this.customerStripeId,
    required this.isSubscribed,
    required this.accessToken,
    required this.subscribedPlan,
    required this.screen,
    required this.screenImage,
     this.response,
  });

  int id;
  String name;
  String email;
  String phone;
  String dob;
  int age;
  String profilePicture;
  String loginType;
  String isLocked;
  int notifyEmail;
  String countryCode;
  String iso;
  String customerPaymentId;
  String subscriptionType;
  String customerStripeId;
  int isSubscribed;
  String accessToken;
  String subscribedPlan;
  String screen;
  String screenImage;
  String? response;

  userResponseDataMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['response'] = response ?? "";
    return mapping;
  }

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    id: json["id"],
    name: json["name"] ?? "",
    response: json["response"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    dob: json["dob"] ?? "",
    age: json["age"]?? "",
    profilePicture: json["profile_picture"]?? "",
    loginType: json["login_type"]?? "",
    isLocked: json["is_locked"]?? "",
    notifyEmail: json["notify_email"]?? "",
    countryCode: json["country_code"]?? "",
    iso: json["iso"]?? "",
    customerPaymentId: json["customer_payment_id"]?? "",
    subscriptionType: json["subscription_type"]?? "",
    customerStripeId: json["customer_stripe_id"]?? "",
    isSubscribed: json["is_subscribed"]?? "",
    accessToken: json["access_token"],
    subscribedPlan: json["subscribed_plan"]?? "",
    screen: json["screen"]?? "",
    screenImage: json["screenImage"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "response": response ?? "",
    "email": email,
    "phone": phone,
    "dob": dob,
    "age": age,
    "profile_picture": profilePicture,
    "login_type": loginType,
    "is_locked": isLocked,
    "notify_email": notifyEmail,
    "country_code": countryCode,
    "iso": iso,
    "customer_payment_id": customerPaymentId,
    "subscription_type": subscriptionType,
    "customer_stripe_id": customerStripeId,
    "is_subscribed": isSubscribed,
    "access_token": accessToken,
    "subscribed_plan": subscribedPlan,
    "screen": screen,
    "screenImage": screenImage,
  };
}
