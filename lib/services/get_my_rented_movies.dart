// To parse this JSON data, do
//
//     final getMyRentedMovies = getMyRentedMoviesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetMyRentedMovies getMyRentedMoviesFromJson(String str) => GetMyRentedMovies.fromJson(json.decode(str));

String getMyRentedMoviesToJson(GetMyRentedMovies data) => json.encode(data.toJson());

class GetMyRentedMovies {
  GetMyRentedMovies({
    required this.error,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
    required this.type,
  });

  bool error;
  int statusCode;
  String status;
  dynamic message;
  Data data;
  String type;

  factory GetMyRentedMovies.fromJson(Map<String, dynamic> json) => GetMyRentedMovies(
    error: json["error"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data.toJson(),
    "type": type,
  };
}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<RentData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<RentData>.from(json["data"].map((x) => RentData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class RentData {
  RentData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.paymentMethodId,
    required this.customerId,
    required this.status,
    required this.transactionMessage,
    required this.transactionId,
    required this.paymentResponse,
    required this.subscriptionPlanId,
    required this.subscriberId,
    required this.planName,
    required this.cardId,
    required this.globalViewCount,
    required this.viewCount,
    required this.videoId,
    required this.amount,
    required this.paidAmount,
    required this.couponId,
    required this.createdAt,
    required this.updatedAt,
    required this.currency,
    required this.customerCode,
    required this.reference,
    required this.paymentMethodName,
    required this.stripeSubscriptionId,
    required this.failureCode,
    required this.transactionType,
    required this.video,
  });

  int id;
  String name;
  String email;
  String phone;
  int paymentMethodId;
  int customerId;
  String status;
  String transactionMessage;
  String transactionId;
  String paymentResponse;
  dynamic subscriptionPlanId;
  dynamic subscriberId;
  String planName;
  dynamic cardId;
  int globalViewCount;
  int viewCount;
  int videoId;
  int amount;
  int paidAmount;
  dynamic couponId;
  DateTime createdAt;
  String updatedAt;
  dynamic currency;
  dynamic customerCode;
  dynamic reference;
  String paymentMethodName;
  dynamic stripeSubscriptionId;
  dynamic failureCode;
  dynamic transactionType;
  Video video;

  factory RentData.fromJson(Map<String, dynamic> json) => RentData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    paymentMethodId: json["payment_method_id"],
    customerId: json["customer_id"],
    status: json["status"],
    transactionMessage: json["transaction_message"],
    transactionId: json["transaction_id"],
    paymentResponse: json["payment_response"],
    subscriptionPlanId: json["subscription_plan_id"],
    subscriberId: json["subscriber_id"],
    planName: json["plan_name"],
    cardId: json["card_id"],
    globalViewCount: json["global_view_count"],
    viewCount: json["view_count"],
    videoId: json["video_id"],
    amount: json["amount"],
    paidAmount: json["paid_amount"],
    couponId: json["coupon_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    currency: json["currency"],
    customerCode: json["customer_code"],
    reference: json["reference"],
    paymentMethodName: json["payment_method_name"],
    stripeSubscriptionId: json["stripe_subscription_id"],
    failureCode: json["failure_code"],
    transactionType: json["transaction_type"],
    video: Video.fromJson(json["video"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "payment_method_id": paymentMethodId,
    "customer_id": customerId,
    "status": status,
    "transaction_message": transactionMessage,
    "transaction_id": transactionId,
    "payment_response": paymentResponse,
    "subscription_plan_id": subscriptionPlanId,
    "subscriber_id": subscriberId,
    "plan_name": planName,
    "card_id": cardId,
    "global_view_count": globalViewCount,
    "view_count": viewCount,
    "video_id": videoId,
    "amount": amount,
    "paid_amount": paidAmount,
    "coupon_id": couponId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "currency": currency,
    "customer_code": customerCode,
    "reference": reference,
    "payment_method_name": paymentMethodName,
    "stripe_subscription_id": stripeSubscriptionId,
    "failure_code": failureCode,
    "transaction_type": transactionType,
    "video": video.toJson(),
  };
}

class Video {
  Video({
    required this.id,
    required this.title,
    required this.slug,
    required this.thumbnailImage,
  });

  int id;
  String title;
  String slug;
  String thumbnailImage;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    thumbnailImage: json["thumbnail_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "thumbnail_image": thumbnailImage,
  };
}
