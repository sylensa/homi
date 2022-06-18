// To parse this JSON data, do
//
//     final getMyTransactions = getMyTransactionsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetMyTransactions getMyTransactionsFromJson(String str) => GetMyTransactions.fromJson(json.decode(str));

String getMyTransactionsToJson(GetMyTransactions data) => json.encode(data.toJson());

class GetMyTransactions {
  GetMyTransactions({
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

  factory GetMyTransactions.fromJson(Map<String, dynamic> json) => GetMyTransactions(
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
  List<TransactionData> data;
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
    data: List<TransactionData>.from(json["data"].map((x) => TransactionData.fromJson(x))),
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

class TransactionData {
  TransactionData({
    required this.id,
    required this.name,
    required this.email,
    required this.customerId,
    required this.transactionType,
    required this.planName,
    required this.videoId,
    required this.transactionId,
    required this.amount,
    required this.status,
    required this.latestReceipt,
    required this.purchaseResponse,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.canceledAt,
    required this.cancellationReason,
    required this.createdAt,
    required this.updatedAt,
    required this.getTransactionUser,
    required this.video,
    required this.getPaymentMethod,
    required this.getSubscriptionPlan,
  });

  int id;
  String name;
  String email;
  int customerId;
  String transactionType;
  String planName;
  int videoId;
  String transactionId;
  double amount;
  String status;
  String latestReceipt;
  String purchaseResponse;
  DateTime subscriptionStartDate;
  DateTime subscriptionEndDate;
  dynamic canceledAt;
  String cancellationReason;
  DateTime createdAt;
  DateTime updatedAt;
  GetTransactionUser getTransactionUser;
  dynamic video;
  dynamic getPaymentMethod;
  dynamic getSubscriptionPlan;

  factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    customerId: json["customer_id"],
    transactionType: json["transaction_type"],
    planName: json["plan_name"],
    videoId: json["video_id"],
    transactionId: json["transaction_id"],
    amount: json["amount"].toDouble(),
    status: json["status"],
    latestReceipt: json["latest_receipt"],
    purchaseResponse: json["purchase_response"],
    subscriptionStartDate: DateTime.parse(json["subscription_start_date"]),
    subscriptionEndDate: DateTime.parse(json["subscription_end_date"]),
    canceledAt: json["canceled_at"],
    cancellationReason: json["cancellation_reason"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    getTransactionUser: GetTransactionUser.fromJson(json["get_transaction_user"]),
    video: json["video"],
    getPaymentMethod: json["get_payment_method"],
    getSubscriptionPlan: json["get_subscription_plan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "customer_id": customerId,
    "transaction_type": transactionType,
    "plan_name": planName,
    "video_id": videoId,
    "transaction_id": transactionId,
    "amount": amount,
    "status": status,
    "latest_receipt": latestReceipt,
    "purchase_response": purchaseResponse,
    "subscription_start_date": "${subscriptionStartDate.year.toString().padLeft(4, '0')}-${subscriptionStartDate.month.toString().padLeft(2, '0')}-${subscriptionStartDate.day.toString().padLeft(2, '0')}",
    "subscription_end_date": "${subscriptionEndDate.year.toString().padLeft(4, '0')}-${subscriptionEndDate.month.toString().padLeft(2, '0')}-${subscriptionEndDate.day.toString().padLeft(2, '0')}",
    "canceled_at": canceledAt,
    "cancellation_reason": cancellationReason,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "get_transaction_user": getTransactionUser.toJson(),
    "video": video,
    "get_payment_method": getPaymentMethod,
    "get_subscription_plan": getSubscriptionPlan,
  };
}

class GetTransactionUser {
  GetTransactionUser({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory GetTransactionUser.fromJson(Map<String, dynamic> json) => GetTransactionUser(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
