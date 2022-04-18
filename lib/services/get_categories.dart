// To parse this JSON data, do
//
//     final getCategories = getCategoriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCategories getCategoriesFromJson(String str) => GetCategories.fromJson(json.decode(str));

String getCategoriesToJson(GetCategories data) => json.encode(data.toJson());

class GetCategories {
  GetCategories({
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

  factory GetCategories.fromJson(Map<String, dynamic> json) => GetCategories(
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
  List<DataCategories> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    currentPage: json["current_page"] ?? "",
    data: List<DataCategories>.from(json["data"].map((x) => DataCategories.fromJson(x))),
    firstPageUrl: json["first_page_url"]?? "",
    from: json["from"]?? "",
    lastPage: json["last_page"]?? "",
    lastPageUrl: json["last_page_url"]?? "",
    nextPageUrl: json["next_page_url"]?? "",
    path: json["path"]?? "",
    perPage: json["per_page"]?? "",
    prevPageUrl: json["prev_page_url"]?? "",
    to: json["to"]?? "",
    total: json["total"]?? "",
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

class DataCategories {
  DataCategories({
    required this.title,
    required this.slug,
    required this.categoryOrder,
    required this.imageUrl,
    required this.isWebSeries,
    required this.videoWebseriesDetailId,
  });

  String title;
  String slug;
  int categoryOrder;
  String imageUrl;
  int isWebSeries;
  String videoWebseriesDetailId;

  factory DataCategories.fromJson(Map<String, dynamic> json) => DataCategories(
    title: json["title"]?? "",
    slug: json["slug"]?? "",
    categoryOrder: json["category_order"]?? "",
    imageUrl: json["image_url"]?? "",
    isWebSeries: json["is_web_series"]?? "",
    videoWebseriesDetailId: json["video_webseries_detail_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "slug": slug,
    "category_order": categoryOrder,
    "image_url": imageUrl,
    "is_web_series": isWebSeries,
    "video_webseries_detail_id": videoWebseriesDetailId,
  };
}
