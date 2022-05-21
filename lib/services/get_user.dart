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
  SubscribedPlan? subscribedPlan;
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
    subscribedPlan: json["subscribed_plan"] == null ? json["subscribed_plan"]  : SubscribedPlan.fromJson(json["subscribed_plan"]),
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
    "subscribed_plan": subscribedPlan == null ? null : subscribedPlan!.toJson(),
    "screen": screen,
    "screenImage": screenImage,
  };
}

class SubscribedPlan {
  SubscribedPlan({
    required this.name,
    required this.type,
    required this.slug,
    required this.amount,
    required this.description,
    required this.duration,
    required this.deviceLimit,
    required this.stripePlanId,
    required this.paystackPlanId,
    required this.inAppId,
    required this.pivot,
  });

  String name;
  String type;
  String slug;
  double amount;
  String description;
  String duration;
  int deviceLimit;
  String stripePlanId;
  String paystackPlanId;
  String inAppId;
  Pivot? pivot;

  factory SubscribedPlan.fromJson(Map<String, dynamic> json) => SubscribedPlan(
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    slug: json["slug"] == null ? null : json["slug"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    description: json["description"] == null ? null : json["description"],
    duration: json["duration"] == null ? null : json["duration"],
    deviceLimit: json["device_limit"] == null ? null : json["device_limit"],
    stripePlanId: json["stripe_plan_id"] == null ? null : json["stripe_plan_id"],
    paystackPlanId: json["paystack_plan_id"] == null ? null : json["paystack_plan_id"],
    inAppId: json["in_app_id"] == null ? null : json["in_app_id"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "slug": slug == null ? null : slug,
    "amount": amount == null ? null : amount,
    "description": description == null ? null : description,
    "duration": duration == null ? null : duration,
    "device_limit": deviceLimit == null ? null : deviceLimit,
    "stripe_plan_id": stripePlanId == null ? null : stripePlanId,
    "paystack_plan_id": paystackPlanId == null ? null : paystackPlanId,
    "in_app_id": inAppId == null ? null : inAppId,
    "pivot": pivot == null ? null : pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    required this.customerId,
    required this.subscriptionPlanId,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  int customerId;
  int subscriptionPlanId;
  DateTime? startDate;
  DateTime? endDate;
  int isActive;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    subscriptionPlanId: json["subscription_plan_id"] == null ? null : json["subscription_plan_id"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    isActive: json["is_active"] == null ? null : json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId == null ? null : customerId,
    "subscription_plan_id": subscriptionPlanId == null ? null : subscriptionPlanId,
    "start_date": startDate == null ? null : "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": endDate == null ? null : "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "is_active": isActive == null ? null : isActive,
  };
}


