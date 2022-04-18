// To parse this JSON data, do
//
//     final getFavouriteVideos = getFavouriteVideosFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetFavouriteVideos getFavouriteVideosFromJson(String str) => GetFavouriteVideos.fromJson(json.decode(str));

String getFavouriteVideosToJson(GetFavouriteVideos data) => json.encode(data.toJson());

class GetFavouriteVideos {
  GetFavouriteVideos({
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

  factory GetFavouriteVideos.fromJson(Map<String, dynamic> json) => GetFavouriteVideos(
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
  List<FavouriteData> data;
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

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    currentPage: json["current_page"],
    data: List<FavouriteData>.from(json["data"].map((x) => FavouriteData.fromJson(x))),
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

class FavouriteData {
  FavouriteData({
    required this.title,
    required this.subtitle,
    required this.slug,
    required this.description,
    required this.thumbnailImage,
    required this.videoDuration,
    required this.videoHeight,
    required this.recordingStatus,
    required this.aspectRatio,
    required this.hlsPlaylistUrl,
    required this.spriteImage,
    required this.spriteImageStatus,
    required this.isLive,
    required this.liveRecordedStatus,
    required this.liveRecordingConfirmation,
    required this.scheduledStartTime,
    required this.jobStatus,
    required this.transcodeStatus,
    required this.uploadPercentage,
    required this.publishedOn,
    required this.videoOrder,
    required this.presenter,
    required this.isActive,
    required this.isPremium,
    required this.isNotify,
    required this.isNotified,
    required this.trailerUrl,
    required this.trailerStatus,
    required this.trailerHlsUrl,
    required this.trailerHlsPrefix,
    required this.trailerJobid,
    required this.isArchived,
    required this.posterImage,
    required this.viewCount,
    required this.audioLanguage,
    required this.videoSize,
    required this.activePresets,
    required this.price,
    required this.isWebseries,
    required this.episodeOrder,
    required this.isApproved,
    required this.videoId,
    required this.gid,
    required this.genreName,
    required this.videoCategoryName,
    required this.isSubscribed,
    required this.categories,
    required this.videoTranslation,
  });

  String title;
  Subtitle subtitle;
  String slug;
  String description;
  String thumbnailImage;
  String videoDuration;
  String videoHeight;
  String recordingStatus;
  String aspectRatio;
  String hlsPlaylistUrl;
  String spriteImage;
  int spriteImageStatus;
  int isLive;
  String liveRecordedStatus;
  String liveRecordingConfirmation;
  String scheduledStartTime;
  String jobStatus;
  String transcodeStatus;
  String uploadPercentage;
  String publishedOn;
  int videoOrder;
  String presenter;
  int isActive;
  int isPremium;
  int isNotify;
  int isNotified;
  String trailerUrl;
  String trailerStatus;
  String trailerHlsUrl;
  String trailerHlsPrefix;
  String trailerJobid;
  int isArchived;
  String posterImage;
  int viewCount;
  String audioLanguage;
  String videoSize;
  String activePresets;
  int price;
  int isWebseries;
  String episodeOrder;
  int isApproved;
  int videoId;
  String gid;
  String genreName;
  String videoCategoryName;
  int isSubscribed;
  List<Category> categories;
  List<dynamic> videoTranslation;

  factory FavouriteData.fromJson(Map<String, dynamic> json) => FavouriteData(
    title: json["title"] ?? "",
    subtitle: Subtitle.fromJson(json["subtitle"]),
    slug: json["slug"] ?? "",
    description: json["description"] ?? "",
    thumbnailImage: json["thumbnail_image"] ?? "",
    videoDuration: json["video_duration"] ?? "",
    videoHeight: json["video_height"] ?? "",
    recordingStatus: json["recording_status"] ?? "",
    aspectRatio: json["aspect_ratio"] ?? "",
    hlsPlaylistUrl: json["hls_playlist_url"] ?? "",
    spriteImage: json["sprite_image"]?? "",
    spriteImageStatus: json["sprite_image_status"]?? 0,
    isLive: json["is_live"] ?? 0,
    liveRecordedStatus: json["live_recorded_status"] ?? "",
    liveRecordingConfirmation: json["live_recording_confirmation"] ?? "",
    scheduledStartTime: json["scheduledStartTime"] ?? "",
    jobStatus: json["job_status"] ?? "",
    transcodeStatus: json["transcode_status"] ?? "",
    uploadPercentage: json["upload_percentage"] ?? "",
    publishedOn: json["published_on"].toString(),
    videoOrder: json["video_order"] ?? 0,
    presenter: json["presenter"] ?? "",
    isActive: json["is_active"]?? 0,
    isPremium: json["is_premium"] ?? 0,
    isNotify: json["is_notify"] ?? 0,
    isNotified: json["is_notified"] ?? 0,
    trailerUrl: json["trailer_url"] ?? "",
    trailerStatus: json["trailer_status"] ?? "",
    trailerHlsUrl: json["trailer_hls_url"]?? "",
    trailerHlsPrefix: json["trailer_hls_prefix"]?? "",
    trailerJobid: json["trailer_jobid"]?? "",
    isArchived: json["is_archived"]?? 0,
    posterImage: json["poster_image"] ?? "",
    viewCount: json["view_count"] ?? 0,
    audioLanguage: json["audio_language"] ?? "",
    videoSize: json["video_size"] ?? "",
    activePresets: json["active_presets"] ?? "",
    price: json["price"] ?? 0,
    isWebseries: json["is_webseries"] ?? 0,
    episodeOrder: json["episode_order"] ?? "",
    isApproved: json["is_approved"] ?? 0,
    videoId: json["video_id"] ?? 0,
    gid: json["gid"] ?? "",
    genreName: json["genre_name"] ?? "",
    videoCategoryName: json["video_category_name"] ?? "",
    isSubscribed: json["is_subscribed"]?? 0,
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    videoTranslation: List<dynamic>.from(json["video_translation"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle.toJson(),
    "slug": slug,
    "description": description,
    "thumbnail_image": thumbnailImage,
    "video_duration": videoDuration,
    "video_height": videoHeight,
    "recording_status": recordingStatus,
    "aspect_ratio": aspectRatio,
    "hls_playlist_url": hlsPlaylistUrl,
    "sprite_image": spriteImage,
    "sprite_image_status": spriteImageStatus,
    "is_live": isLive,
    "live_recorded_status": liveRecordedStatus,
    "live_recording_confirmation": liveRecordingConfirmation,
    "scheduledStartTime": scheduledStartTime,
    "job_status": jobStatus,
    "transcode_status": transcodeStatus,
    "upload_percentage": uploadPercentage,
    "published_on": publishedOn,
    "video_order": videoOrder,
    "presenter": presenter,
    "is_active": isActive,
    "is_premium": isPremium,
    "is_notify": isNotify,
    "is_notified": isNotified,
    "trailer_url": trailerUrl,
    "trailer_status": trailerStatus,
    "trailer_hls_url": trailerHlsUrl,
    "trailer_hls_prefix": trailerHlsPrefix,
    "trailer_jobid": trailerJobid,
    "is_archived": isArchived,
    "poster_image": posterImage,
    "view_count": viewCount,
    "audio_language": audioLanguage,
    "video_size": videoSize,
    "active_presets": activePresets,
    "price": price,
    "is_webseries": isWebseries,
    "episode_order": episodeOrder,
    "is_approved": isApproved,
    "video_id": videoId,
    "gid": gid,
    "genre_name": genreName,
    "video_category_name": videoCategoryName,
    "is_subscribed": isSubscribed,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "video_translation": List<dynamic>.from(videoTranslation.map((x) => x)),
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

class Subtitle {
  Subtitle({
    required this.baseUrl,
    required this.subtitleList,
  });

  String baseUrl;
  List<dynamic> subtitleList;

  factory Subtitle.fromJson(Map<String, dynamic> json) => Subtitle(
    baseUrl: json["base_url"],
    subtitleList: List<dynamic>.from(json["subtitle_list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "base_url": baseUrl,
    "subtitle_list": List<dynamic>.from(subtitleList.map((x) => x)),
  };
}
