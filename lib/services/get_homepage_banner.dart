// To parse this JSON data, do
//
//     final getHomePageBanner = getHomePageBannerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetHomePageBanner getHomePageBannerFromJson(String str) => GetHomePageBanner.fromJson(json.decode(str));

String getHomePageBannerToJson(GetHomePageBanner data) => json.encode(data.toJson());

class GetHomePageBanner {
  GetHomePageBanner({
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
  ResponseBanner response;

  factory GetHomePageBanner.fromJson(Map<String, dynamic> json) => GetHomePageBanner(
    error: json["error"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    response: ResponseBanner.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "response": response.toJson(),
  };
}

class ResponseBanner {
  ResponseBanner({
    required this.banner,
    required this.responseNew,
  });

  BannerResponse banner;
  BannerResponse responseNew;

  factory ResponseBanner.fromJson(Map<String, dynamic> json) => ResponseBanner(
    banner: BannerResponse.fromJson(json["banner"]),
    responseNew: BannerResponse.fromJson(json["new"]),
  );

  Map<String, dynamic> toJson() => {
    "banner": banner.toJson(),
    "new": responseNew.toJson(),
  };
}

class BannerResponse {
  BannerResponse({
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
    required this.categoryName,
    required this.categorySlug,
    required this.type,
    required this.newData,
  });

  int currentPage;
  List<BannerData> data;
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
  String categoryName;
  String categorySlug;
  String type;
  List<BannerData> newData;

  factory BannerResponse.fromJson(Map<String, dynamic> json) => BannerResponse(
    currentPage: json["current_page"] ?? 0,
    data:  List<BannerData>.from(json["data"].map((x) => BannerData.fromJson(x))),
    firstPageUrl: json["first_page_url"] ?? "",
    from: json["from"] ?? 0,
    lastPage: json["last_page"] ?? 0,
    lastPageUrl: json["last_page_url"]?? "",
    nextPageUrl: json["next_page_url"] ?? "",
    path: json["path"] ?? "",
    perPage: json["per_page"] ?? 0,
    prevPageUrl: json["prev_page_url"] ?? "",
    to: json["to"] ?? 0,
    total: json["total"]?? 0,
    categoryName: json["category_name"]?? "",
    categorySlug: json["category_slug"] ?? "",
    type: json["type"] ?? "",
    newData:  List<BannerData>.from(json["data"].map((x) => BannerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl == null ? null : nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
    "category_name": categoryName,
    "category_slug": categorySlug,
    "type": type,
    "data": newData == null ? null : List<dynamic>.from(newData.map((x) => x.toJson())),
  };
}

class BannerData {
  BannerData({
    required this.id,
    required this.title,
    required this.slug,
    required this.thumbnailImage,
    required this.posterImage,
    required this.isFavourite,
    required this.isLive,
    required this.viewCount,
    required this.isPremium,
    required this.trailerHlsUrl,
    required this.trailerStatus,
    required this.publishedOn,
    required this.videoDuration,
    required this.description,
    required this.passphrase,
    required this.genreName,
    required this.videoCategoryName,
    required this.isSubscribed,
    required this.videoArea,
    required this.categories,
    required this.tvPosterImage,
    required this.mobilePosterImage,
  });

  int id;
  String title;
  String slug;
  String thumbnailImage;
  String posterImage;
  int isFavourite;
  int isLive;
  int viewCount;
  int isPremium;
  String trailerHlsUrl;
  String trailerStatus;
  String publishedOn;
  String videoDuration;
  String description;
  String passphrase;
  String genreName;
  String videoCategoryName;
  int isSubscribed;
  String videoArea;
  List<Category>? categories;
  String tvPosterImage;
  String mobilePosterImage;

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    id: json["id"] ?? 0,
    title: json["title"],
    slug: json["slug"],
    thumbnailImage: json["thumbnail_image"],
    posterImage: json["poster_image"] ?? "",
    isFavourite: json["is_favourite"],
    isLive: json["is_live"],
    viewCount: json["view_count"],
    isPremium: json["is_premium"],
    trailerHlsUrl: json["trailer_hls_url"] ?? "",
    trailerStatus: json["trailer_status"] ?? "",
    publishedOn: json["published_on"].toString() ,
    videoDuration: json["video_duration"] ?? "",
    description: json["description"],
    passphrase: json["passphrase"] ?? "",
    genreName: json["genre_name"],
    videoCategoryName: json["video_category_name"],
    isSubscribed: json["is_subscribed"],
    videoArea: json["video_area"] ?? "",
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    tvPosterImage: json["tv_poster_image"] ?? "",
    mobilePosterImage: json["mobile_poster_image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title,
    "slug": slug,
    "thumbnail_image": thumbnailImage,
    "poster_image": posterImage,
    "is_favourite": isFavourite,
    "is_live": isLive,
    "view_count": viewCount,
    "is_premium": isPremium,
    "trailer_hls_url": trailerHlsUrl,
    "trailer_status": trailerStatus ,
    "published_on": publishedOn.toString(),
    "video_duration": videoDuration,
    "description": description,
    "passphrase": passphrase ,
    "genre_name": genreName,
    "video_category_name": videoCategoryName,
    "is_subscribed": isSubscribed,
    "video_area": videoArea,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "tv_poster_image": tvPosterImage ,
    "mobile_poster_image": mobilePosterImage ,
  };
}

class Category {
  Category({
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
  dynamic videoWebseriesDetailId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    title: json["title"],
    slug: json["slug"],
    categoryOrder: json["category_order"],
    imageUrl: json["image_url"],
    isWebSeries: json["is_web_series"],
    videoWebseriesDetailId: json["video_webseries_detail_id"],
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
