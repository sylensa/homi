// To parse this JSON data, do
//
//     final getSeries = getSeriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSeries getSeriesFromJson(String str) => GetSeries.fromJson(json.decode(str));

String getSeriesToJson(GetSeries data) => json.encode(data.toJson());

class GetSeries {
  GetSeries({
    required this.error,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.response,
  });

  bool error;
  int? statusCode;
  String status;
  String message;
  ResponseSeries? response;

  factory GetSeries.fromJson(Map<String, dynamic> json) => GetSeries(
    error: json["error"] == null ? null : json["error"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["response"] == null ? null : ResponseSeries.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "statusCode": statusCode == null ? null : statusCode,
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "response": response == null ? null : response!.toJson(),
  };
}

class ResponseSeries {
  ResponseSeries({
    required this.webseriesInfo,
    required this.related,
    required this.seasons,
  });

  WebseriesInfo? webseriesInfo;
  Related? related;
  List<Season>? seasons;

  factory ResponseSeries.fromJson(Map<String, dynamic> json) => ResponseSeries(
    webseriesInfo: json["webseries_info"] == null ? null : WebseriesInfo.fromJson(json["webseries_info"]),
    related: json["related"] == null ? null : Related.fromJson(json["related"]),
    seasons: json["seasons"] == null ? null : List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "webseries_info": webseriesInfo == null ? null : webseriesInfo!.toJson(),
    "related": related == null ? null : related!.toJson(),
    "seasons": seasons == null ? null : List<dynamic>.from(seasons!.map((x) => x.toJson())),
  };
}

class Related {
  Related({
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

  int? currentPage;
  List<GetSeriesData>? data;
  String firstPageUrl;
  int? from;
  int? lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Related.fromJson(Map<String, dynamic> json) => Related(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<GetSeriesData>.from(json["data"].map((x) => GetSeriesData.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "last_page_url": lastPageUrl == null ? null : lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class GetSeriesData {
  GetSeriesData({
    required this.title,
    required this.slug,
    required this.thumbnailImage,
    required this.isFavourite,
    required this.videoCategoryName,
    required this.isLike,
    required this.isDislike,
    required this.likeCount,
    required this.dislikeCount,
    required this.autoPlay,
    required this.seasonName,
    required this.seasonId,
    required this.price,
    required this.posterImage,
    required this.videoCategorySlug,
    required this.parentCategorySlug,
    required this.trailerHlsUrl,
    required this.trailerStatus,
    required this.publishedOn,
    required this.viewCount,
    required this.videoDuration,
    required this.description,
    required this.genreName,
    required this.isSubscribed,
    required this.videoArea,
    required this.videoRating,
  });

  String? title;
  String? slug;
  String? thumbnailImage;
  int? isFavourite;
  String? videoCategoryName;
  int? isLike;
  int? isDislike;
  int? likeCount;
  int? dislikeCount;
  int? autoPlay;
  String? seasonName;
  int? seasonId;
  int? price;
  String? posterImage;
  String? videoCategorySlug;
  String? parentCategorySlug;
  String? trailerHlsUrl;
  String? trailerStatus;
  DateTime? publishedOn;
  int? viewCount;
  String? videoDuration;
  String? description;
  String? genreName;
  int? isSubscribed;
  String? videoArea;
  dynamic videoRating;

  factory GetSeriesData.fromJson(Map<String, dynamic> json) => GetSeriesData(
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    thumbnailImage: json["thumbnail_image"] == null ? null : json["thumbnail_image"],
    isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
    videoCategoryName: json["video_category_name"] == null ? null : json["video_category_name"],
    isLike: json["is_like"] == null ? null : json["is_like"],
    isDislike: json["is_dislike"] == null ? null : json["is_dislike"],
    likeCount: json["like_count"] == null ? null : json["like_count"],
    dislikeCount: json["dislike_count"] == null ? null : json["dislike_count"],
    autoPlay: json["auto_play"] == null ? null : json["auto_play"],
    seasonName: json["season_name"] == null ? null : json["season_name"],
    seasonId: json["season_id"] == null ? null : json["season_id"],
    price: json["price"] == null ? null : json["price"],
    posterImage: json["poster_image"] == null ? null : json["poster_image"],
    videoCategorySlug: json["video_category_slug"] == null ? null : json["video_category_slug"],
    parentCategorySlug: json["parent_category_slug"] == null ? null : json["parent_category_slug"],
    trailerHlsUrl: json["trailer_hls_url"] == null ? null : json["trailer_hls_url"],
    trailerStatus: json["trailer_status"] == null ? null : json["trailer_status"],
    publishedOn: json["published_on"] == null ? null : DateTime.parse(json["published_on"]),
    viewCount: json["view_count"] == null ? null : json["view_count"],
    videoDuration: json["video_duration"] == null ? null : json["video_duration"],
    description: json["description"] == null ? null : json["description"],
    genreName: json["genre_name"] == null ? null : json["genre_name"],
    isSubscribed: json["is_subscribed"] == null ? null : json["is_subscribed"],
    videoArea: json["video_area"] == null ? null : json["video_area"],
    videoRating: json["video_rating"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "thumbnail_image": thumbnailImage == null ? null : thumbnailImage,
    "is_favourite": isFavourite == null ? null : isFavourite,
    "video_category_name": videoCategoryName == null ? null : videoCategoryName,
    "is_like": isLike == null ? null : isLike,
    "is_dislike": isDislike == null ? null : isDislike,
    "like_count": likeCount == null ? null : likeCount,
    "dislike_count": dislikeCount == null ? null : dislikeCount,
    "auto_play": autoPlay == null ? null : autoPlay,
    "season_name": seasonName == null ? null : seasonName,
    "season_id": seasonId == null ? null : seasonId,
    "price": price == null ? null : price,
    "poster_image": posterImage == null ? null : posterImage,
    "video_category_slug": videoCategorySlug == null ? null : videoCategorySlug,
    "parent_category_slug": parentCategorySlug == null ? null : parentCategorySlug,
    "trailer_hls_url": trailerHlsUrl == null ? null : trailerHlsUrl,
    "trailer_status": trailerStatus == null ? null : trailerStatus,
    "published_on": publishedOn == null ? null : "${publishedOn!.year.toString().padLeft(4, '0')}-${publishedOn!.month.toString().padLeft(2, '0')}-${publishedOn!.day.toString().padLeft(2, '0')}",
    "view_count": viewCount == null ? null : viewCount,
    "video_duration": videoDuration == null ? null : videoDuration,
    "description": description == null ? null : description,
    "genre_name": genreName == null ? null : genreName,
    "is_subscribed": isSubscribed == null ? null : isSubscribed,
    "video_area": videoArea == null ? null : videoArea,
    "video_rating": videoRating,
  };
}

class Season {
  Season({
    required this.id,
    required this.title,
    required this.seasonOrder,
  });

  int? id;
  String? title;
  int? seasonOrder;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    seasonOrder: json["season_order"] == null ? null : json["season_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "season_order": seasonOrder == null ? null : seasonOrder,
  };
}

class WebseriesDetail {
  WebseriesDetail({
    required this.title,
    required this.slug,
    required this.description,
    required this.thumbnailImage,
    required this.posterImage,
    required this.starring,
    required this.genreId,
    required this.parentCategoryId,
    required this.createdAt,
    required this.webseriesOrder,
    required this.isActiveHome,
    required this.genre,
    required this.parentCategory,
  });

  String? title;
  String? slug;
  String? description;
  String? thumbnailImage;
  String? posterImage;
  String? starring;
  int? genreId;
  int? parentCategoryId;
  DateTime? createdAt;
  dynamic webseriesOrder;
  int? isActiveHome;
  Genre? genre;
  WebseriesInfo? parentCategory;

  factory WebseriesDetail.fromJson(Map<String, dynamic> json) => WebseriesDetail(
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    description: json["description"] == null ? null : json["description"],
    thumbnailImage: json["thumbnail_image"] == null ? null : json["thumbnail_image"],
    posterImage: json["poster_image"] == null ? null : json["poster_image"],
    starring: json["starring"] == null ? null : json["starring"],
    genreId: json["genre_id"] == null ? null : json["genre_id"],
    parentCategoryId: json["parent_category_id"] == null ? null : json["parent_category_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    webseriesOrder: json["webseries_order"],
    isActiveHome: json["is_active_home"] == null ? null : json["is_active_home"],
    genre: json["genre"] == null ? null : Genre.fromJson(json["genre"]),
    parentCategory: json["parent_category"] == null ? null : WebseriesInfo.fromJson(json["parent_category"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "description": description == null ? null : description,
    "thumbnail_image": thumbnailImage == null ? null : thumbnailImage,
    "poster_image": posterImage == null ? null : posterImage,
    "starring": starring == null ? null : starring,
    "genre_id": genreId == null ? null : genreId,
    "parent_category_id": parentCategoryId == null ? null : parentCategoryId,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "webseries_order": webseriesOrder,
    "is_active_home": isActiveHome == null ? null : isActiveHome,
    "genre": genre == null ? null : genre!.toJson(),
    "parent_category": parentCategory == null ? null : parentCategory!.toJson(),
  };
}

class WebseriesInfo {
  WebseriesInfo({
    required this.title,
    required this.slug,
    required this.categoryOrder,
    required this.imageUrl,
    required this.isWebSeries,
    required this.videoWebseriesDetailId,
    required this.webseriesDetail,
  });

  String? title;
  String? slug;
  int? categoryOrder;
  String? imageUrl;
  int? isWebSeries;
  int? videoWebseriesDetailId;
  WebseriesDetail? webseriesDetail;

  factory WebseriesInfo.fromJson(Map<String, dynamic> json) => WebseriesInfo(
    title: json["title"] == null ? "" : json["title"],
    slug: json["slug"] == null ? "" : json["slug"],
    categoryOrder: json["category_order"] == null ? 0 : json["category_order"],
    imageUrl: json["image_url"] == null ? "" : json["image_url"],
    isWebSeries: json["is_web_series"] == null ? 0 : json["is_web_series"],
    videoWebseriesDetailId: json["video_webseries_detail_id"] == null ? 0 : json["video_webseries_detail_id"],
    webseriesDetail: json["webseries_detail"] == null ? null : WebseriesDetail.fromJson(json["webseries_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "category_order": categoryOrder == null ? null : categoryOrder,
    "image_url": imageUrl == null ? null : imageUrl,
    "is_web_series": isWebSeries == null ? null : isWebSeries,
    "video_webseries_detail_id": videoWebseriesDetailId == null ? null : videoWebseriesDetailId,
    "webseries_detail": webseriesDetail == null ? null : webseriesDetail!.toJson(),
  };
}

class Genre {
  Genre({
    required this.name,
    required this.slug,
    required this.groupImage,
  });

  String? name;
  String? slug;
  String? groupImage;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    name: json["name"] == null ? null : json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    groupImage: json["group_image"] == null ? null : json["group_image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "slug": slug == null ? null : slug,
    "group_image": groupImage == null ? null : groupImage,
  };
}
