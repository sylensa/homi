// To parse this JSON data, do
//
//     final getCategoryVideos = getCategoryVideosFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCategoryVideos getCategoryVideosFromJson(String str) => GetCategoryVideos.fromJson(json.decode(str));

String getCategoryVideosToJson(GetCategoryVideos data) => json.encode(data.toJson());

class GetCategoryVideos {
  GetCategoryVideos({
    required this.error,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.response,
  });

  bool error;
  int statusCode;
  String status;
  String message;
  Response response;

  factory GetCategoryVideos.fromJson(Map<String, dynamic> json) => GetCategoryVideos(
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
    required this.main,
    required this.categoryVideos,
    required this.genreVideos,
    required this.webSeries,
  });

  List<Main> main;
  List<dynamic> categoryVideos;
  List<dynamic> genreVideos;
  int webSeries;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    main: List<Main>.from(json["main"].map((x) => Main.fromJson(x))),
    categoryVideos: List<dynamic>.from(json["category_videos"].map((x) => x)),
    genreVideos: List<dynamic>.from(json["genre_videos"].map((x) => x)),
    webSeries: json["web_series"],
  );

  Map<String, dynamic> toJson() => {
    "main": List<dynamic>.from(main.map((x) => x.toJson())),
    "category_videos": List<dynamic>.from(categoryVideos.map((x) => x)),
    "genre_videos": List<dynamic>.from(genreVideos.map((x) => x)),
    "web_series": webSeries,
  };
}

class Main {
  Main({
    required this.videoList,
    required this.title,
    required this.type,
    required this.id,
  });

  VideoList videoList;
  String title;
  String type;
  String id;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    videoList: VideoList.fromJson(json["video_list"]),
    title: json["title"]?? "",
    type: json["type"] ?? "",
    id: json["id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "video_list": videoList.toJson(),
    "title": title,
    "type": type,
    "id": id,
  };
}

class VideoList {
  VideoList({
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
  List<VideoData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
    currentPage: json["current_page"] ?? 0,
    data: List<VideoData>.from(json["data"].map((x) => VideoData.fromJson(x))),
    firstPageUrl: json["first_page_url"] ?? "",
    from: json["from"] ?? 0,
    lastPage: json["last_page"] ?? 0,
    lastPageUrl: json["last_page_url"] ?? "",
    nextPageUrl: json["next_page_url"] ?? "",
    path: json["path"] ?? "",
    perPage: json["per_page"] ?? 0,
    prevPageUrl: json["prev_page_url"] ?? "",
    to: json["to"] ?? 0,
    total: json["total"] ?? 0,
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

class VideoData {
  VideoData({
    required this.title,
    required this.slug,
    required this.thumbnailImage,
    required this.posterImage,
    required this.isLive,
    required this.isPremium,
    required this.price,
    required this.trailerHlsUrl,
    required this.trailerStatus,
    required this.publishedOn,
    required this.videoDuration,
    required this.description,
    required this.viewCount,
    required this.isFavourite,
    required this.genreName,
    required this.videoCategoryName,
    required this.isSubscribed,
    required this.videoArea,
  });

  String title;
  String slug;
  String thumbnailImage;
  String posterImage;
  int isLive;
  int isPremium;
  int price;
  String trailerHlsUrl;
  String trailerStatus;
  String publishedOn;
  String videoDuration;
  String description;
  int viewCount;
  int isFavourite;
  String genreName;
  String videoCategoryName;
  int isSubscribed;
  String videoArea;

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
      title: json["title"] ?? "",
      slug: json["slug"] ?? "",
      thumbnailImage: json["thumbnail_image"],
      posterImage: json["poster_image"] ?? "",
      isFavourite: json["is_favourite"] ?? 0,
      isLive: json["is_live"] ?? 0,
      viewCount: json["view_count"] ?? 0,
      isPremium: json["is_premium"] ?? 0,
      trailerHlsUrl: json["trailer_hls_url"] ?? "",
      trailerStatus: json["trailer_status"] ?? "",
      publishedOn: json["published_on"].toString() ,
      videoDuration: json["video_duration"] ?? "",
      description: json["description"] ?? "",
      genreName: json["genre_name"] ?? "",
      videoCategoryName: json["video_category_name"] ?? "",
      isSubscribed: json["is_subscribed"] ?? 0,
      videoArea: json["video_area"] ?? "",
    price: json["price"] ?? 0
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "slug": slug,
    "thumbnail_image": thumbnailImage,
    "poster_image": posterImage == null ? null : posterImage,
    "is_live": isLive,
    "is_premium": isPremium,
    "price": price,
    "trailer_hls_url": trailerHlsUrl == null ? null : trailerHlsUrl,
    "trailer_status": trailerStatus == null ? null : trailerStatus,
    "published_on": publishedOn,
    "video_duration": videoDuration,
    "description": description,
    "view_count": viewCount,
    "is_favourite": isFavourite,
    "genre_name": genreName,
    "video_category_name": videoCategoryName,
    "is_subscribed": isSubscribed,
    "video_area": videoArea ,
  };
}




