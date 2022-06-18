// To parse this JSON data, do
//
//     final getHistoryMovies = getHistoryMoviesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetHistoryMovies getHistoryMoviesFromJson(String? str) => GetHistoryMovies.fromJson(json.decode(str!));

String? getHistoryMoviesToJson(GetHistoryMovies data) => json.encode(data.toJson());

class GetHistoryMovies {
  GetHistoryMovies({
    required this.error,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.response,
  });

  bool? error;
  int? statusCode;
  String? status;
  String? message;
  List<ResponseContinueData>? response;

  factory GetHistoryMovies.fromJson(Map<String, dynamic> json) => GetHistoryMovies(
    error: json["error"] == null ? null : json["error"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["response"] == null ? null : List<ResponseContinueData>.from(json["response"].map((x) => ResponseContinueData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "statusCode": statusCode == null ? null : statusCode,
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
  };
}

class ResponseContinueData {
  ResponseContinueData({
    required this.id,
    required this.customerId,
    required this.videoId,
    required this.seconds,
    required this.continueWatchingIsActive,
    required this.updatedAt,
    required this.createdAt,
    required this.progressPercentage,
    required this.videoDurationSeonds,
    required this.video,
  });

  Id? id;
  int? customerId;
  int? videoId;
  double seconds;
  int? continueWatchingIsActive;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? progressPercentage;
  dynamic videoDurationSeonds;
  Video? video;

  factory ResponseContinueData.fromJson(Map<String, dynamic> json) => ResponseContinueData(
    id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    videoId: json["video_id"] == null ? null : json["video_id"],
    seconds: json["seconds"] == null ? null : json["seconds"].toDouble(),
    continueWatchingIsActive: json["continue_watching_is_active"] == null ? null : json["continue_watching_is_active"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    progressPercentage: json["progress_percentage"] == null ? null : json["progress_percentage"],
    videoDurationSeonds: json["video_duration_seonds"],
    video: json["video"] == null ? null : Video.fromJson(json["video"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id!.toJson(),
    "customer_id": customerId == null ? null : customerId,
    "video_id": videoId == null ? null : videoId,
    "seconds": seconds == null ? null : seconds,
    "continue_watching_is_active": continueWatchingIsActive == null ? null : continueWatchingIsActive,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "progress_percentage": progressPercentage == null ? null : progressPercentage,
    "video_duration_seonds": videoDurationSeonds,
    "video": video == null ? null : video!.toJson(),
  };
}

class Id {
  Id({
    required this.customerId,
    required this.videoId,
  });

  int? customerId;
  int? videoId;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    videoId: json["video_id"] == null ? null : json["video_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId == null ? null : customerId,
    "video_id": videoId == null ? null : videoId,
  };
}

class Video {
  Video({
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
    required this.streamId,
    required this.sourceUrl,
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
    required this.videoArea,
    required this.videoRating,
  });

  String? title;
  Subtitle? subtitle;
  String? slug;
  String? description;
  String? thumbnailImage;
  String? videoDuration;
  String? videoHeight;
  dynamic recordingStatus;
  dynamic aspectRatio;
  String? hlsPlaylistUrl;
  String? spriteImage;
  int? spriteImageStatus;
  int? isLive;
  dynamic liveRecordedStatus;
  dynamic liveRecordingConfirmation;
  String? scheduledStartTime;
  String? jobStatus;
  String? transcodeStatus;
  String? uploadPercentage;
  DateTime? publishedOn;
  int? videoOrder;
  String? presenter;
  dynamic streamId;
  dynamic sourceUrl;
  int? isActive;
  int? isPremium;
  int? isNotify;
  int? isNotified;
  dynamic trailerUrl;
  dynamic trailerStatus;
  dynamic trailerHlsUrl;
  dynamic trailerHlsPrefix;
  dynamic trailerJobid;
  int? isArchived;
  String? posterImage;
  int? viewCount;
  dynamic audioLanguage;
  String? videoSize;
  String? activePresets;
  int? price;
  int? isWebseries;
  dynamic episodeOrder;
  int? isApproved;
  int? videoId;
  dynamic gid;
  String? genreName;
  String? videoCategoryName;
  int? isSubscribed;
  String? videoArea;
  dynamic videoRating;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    title: json["title"] == null ? null : json["title"],
    subtitle: json["subtitle"] == null ? null : Subtitle.fromJson(json["subtitle"]),
    slug: json["slug"] == null ? null : json["slug"],
    description: json["description"] == null ? null : json["description"],
    thumbnailImage: json["thumbnail_image"] == null ? null : json["thumbnail_image"],
    videoDuration: json["video_duration"] == null ? null : json["video_duration"],
    videoHeight: json["video_height"] == null ? null : json["video_height"],
    recordingStatus: json["recording_status"],
    aspectRatio: json["aspect_ratio"],
    hlsPlaylistUrl: json["hls_playlist_url"] == null ? null : json["hls_playlist_url"],
    spriteImage: json["sprite_image"] == null ? null : json["sprite_image"],
    spriteImageStatus: json["sprite_image_status"] == null ? null : json["sprite_image_status"],
    isLive: json["is_live"] == null ? null : json["is_live"],
    liveRecordedStatus: json["live_recorded_status"],
    liveRecordingConfirmation: json["live_recording_confirmation"],
    scheduledStartTime: json["scheduledStartTime"] == null ? null : json["scheduledStartTime"],
    jobStatus: json["job_status"] == null ? null : json["job_status"],
    transcodeStatus: json["transcode_status"] == null ? null : json["transcode_status"],
    uploadPercentage: json["upload_percentage"] == null ? null : json["upload_percentage"],
    publishedOn: json["published_on"] == null ? null : DateTime.parse(json["published_on"]),
    videoOrder: json["video_order"] == null ? null : json["video_order"],
    presenter: json["presenter"] == null ? null : json["presenter"],
    streamId: json["stream_id"],
    sourceUrl: json["source_url"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    isPremium: json["is_premium"] == null ? null : json["is_premium"],
    isNotify: json["is_notify"] == null ? null : json["is_notify"],
    isNotified: json["is_notified"] == null ? null : json["is_notified"],
    trailerUrl: json["trailer_url"],
    trailerStatus: json["trailer_status"],
    trailerHlsUrl: json["trailer_hls_url"],
    trailerHlsPrefix: json["trailer_hls_prefix"],
    trailerJobid: json["trailer_jobid"],
    isArchived: json["is_archived"] == null ? null : json["is_archived"],
    posterImage: json["poster_image"] == null ? null : json["poster_image"],
    viewCount: json["view_count"] == null ? null : json["view_count"],
    audioLanguage: json["audio_language"],
    videoSize: json["video_size"] == null ? null : json["video_size"],
    activePresets: json["active_presets"] == null ? null : json["active_presets"],
    price: json["price"] == null ? null : json["price"],
    isWebseries: json["is_webseries"] == null ? null : json["is_webseries"],
    episodeOrder: json["episode_order"],
    isApproved: json["is_approved"] == null ? null : json["is_approved"],
    videoId: json["video_id"] == null ? null : json["video_id"],
    gid: json["gid"],
    genreName: json["genre_name"] == null ? null : json["genre_name"],
    videoCategoryName: json["video_category_name"] == null ? null : json["video_category_name"],
    isSubscribed: json["is_subscribed"] == null ? null : json["is_subscribed"],
    videoArea: json["video_area"] == null ? null : json["video_area"],
    videoRating: json["video_rating"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "subtitle": subtitle == null ? null : subtitle!.toJson(),
    "slug": slug == null ? null : slug,
    "description": description == null ? null : description,
    "thumbnail_image": thumbnailImage == null ? null : thumbnailImage,
    "video_duration": videoDuration == null ? null : videoDuration,
    "video_height": videoHeight == null ? null : videoHeight,
    "recording_status": recordingStatus,
    "aspect_ratio": aspectRatio,
    "hls_playlist_url": hlsPlaylistUrl == null ? null : hlsPlaylistUrl,
    "sprite_image": spriteImage == null ? null : spriteImage,
    "sprite_image_status": spriteImageStatus == null ? null : spriteImageStatus,
    "is_live": isLive == null ? null : isLive,
    "live_recorded_status": liveRecordedStatus,
    "live_recording_confirmation": liveRecordingConfirmation,
    "scheduledStartTime": scheduledStartTime == null ? null : scheduledStartTime,
    "job_status": jobStatus == null ? null : jobStatus,
    "transcode_status": transcodeStatus == null ? null : transcodeStatus,
    "upload_percentage": uploadPercentage == null ? null : uploadPercentage,
    "published_on": publishedOn == null ? null : "${publishedOn!.year.toString().padLeft(4, '0')}-${publishedOn!.month.toString().padLeft(2, '0')}-${publishedOn!.day.toString().padLeft(2, '0')}",
    "video_order": videoOrder == null ? null : videoOrder,
    "presenter": presenter == null ? null : presenter,
    "stream_id": streamId,
    "source_url": sourceUrl,
    "is_active": isActive == null ? null : isActive,
    "is_premium": isPremium == null ? null : isPremium,
    "is_notify": isNotify == null ? null : isNotify,
    "is_notified": isNotified == null ? null : isNotified,
    "trailer_url": trailerUrl,
    "trailer_status": trailerStatus,
    "trailer_hls_url": trailerHlsUrl,
    "trailer_hls_prefix": trailerHlsPrefix,
    "trailer_jobid": trailerJobid,
    "is_archived": isArchived == null ? null : isArchived,
    "poster_image": posterImage == null ? null : posterImage,
    "view_count": viewCount == null ? null : viewCount,
    "audio_language": audioLanguage,
    "video_size": videoSize == null ? null : videoSize,
    "active_presets": activePresets == null ? null : activePresets,
    "price": price == null ? null : price,
    "is_webseries": isWebseries == null ? null : isWebseries,
    "episode_order": episodeOrder,
    "is_approved": isApproved == null ? null : isApproved,
    "video_id": videoId == null ? null : videoId,
    "gid": gid,
    "genre_name": genreName == null ? null : genreName,
    "video_category_name": videoCategoryName == null ? null : videoCategoryName,
    "is_subscribed": isSubscribed == null ? null : isSubscribed,
    "video_area": videoArea == null ? null : videoArea,
    "video_rating": videoRating,
  };
}

class Subtitle {
  Subtitle({
    required this.baseUrl,
    required this.subtitleList,
  });

  String? baseUrl;
  List<dynamic>? subtitleList;

  factory Subtitle.fromJson(Map<String, dynamic> json) => Subtitle(
    baseUrl: json["base_url"] == null ? null : json["base_url"],
    subtitleList: json["subtitle_list"] == null ? null : List<dynamic>.from(json["subtitle_list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "base_url": baseUrl == null ? null : baseUrl,
    "subtitle_list": subtitleList == null ? null : List<dynamic>.from(subtitleList!.map((x) => x)),
  };
}
