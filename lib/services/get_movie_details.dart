// To parse this JSON data, do
//
//     final getMovieDetails = getMovieDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetMovieDetails getMovieDetailsFromJson(String str) => GetMovieDetails.fromJson(json.decode(str));

String getMovieDetailsToJson(GetMovieDetails data) => json.encode(data.toJson());

class GetMovieDetails {
  GetMovieDetails({
    required this.error,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.response,
  });

  bool error;
  int statusCode;
  String? status;
  String? message;
  Response? response;

  factory GetMovieDetails.fromJson(Map<String, dynamic> json) => GetMovieDetails(
    error: json["error"] == null ? null : json["error"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "statusCode": statusCode == null ? null : statusCode,
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "response": response == null ? null : response!.toJson(),
  };
}

class Response {
  Response({
    required this.videoInfo,
    required this.related,
    required this.continueWatchingDetail,
    required this.comments,
    required this.seasons,
    required this.paymentInfo,
    required this.videoMetaData,
  });

  VideoInfo? videoInfo;
  Comments? related;
  dynamic continueWatchingDetail;
  Comments? comments;
  List<dynamic>? seasons;
  PaymentInfo? paymentInfo;
  dynamic videoMetaData;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    videoInfo: json["video_info"] == null ? null : VideoInfo.fromJson(json["video_info"]),
    related: json["related"] == null ? null : Comments.fromJson(json["related"]),
    continueWatchingDetail: json["continue_watching_detail"],
    comments: json["comments"] == null ? null : Comments.fromJson(json["comments"]),
    seasons: json["seasons"] == null ? null : List<dynamic>.from(json["seasons"].map((x) => x)),
    paymentInfo: json["payment_info"] == null ? null : PaymentInfo.fromJson(json["payment_info"]),
    videoMetaData: json["video_meta_data"],
  );

  Map<String, dynamic> toJson() => {
    "video_info": videoInfo == null ? null : videoInfo!.toJson(),
    "related": related == null ? null : related!.toJson(),
    "continue_watching_detail": continueWatchingDetail,
    "comments": comments == null ? null : comments!.toJson(),
    "seasons": seasons == null ? null : List<dynamic>.from(seasons!.map((x) => x)),
    "payment_info": paymentInfo == null ? null : paymentInfo!.toJson(),
    "video_meta_data": videoMetaData,
  };
}

class Comments {
  Comments({
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
  List<MovieDetails>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<MovieDetails>.from(json["data"].map((x) => MovieDetails.fromJson(x))),
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

class MovieDetails {
  MovieDetails({
    required this.title,
    required this.slug,
    required this.thumbnailImage,
    required this.posterImage,
    required this.isFavourite,
    required this.isLive,
    required this.viewCount,
    required this.isPremium,
    required this.price,
    required this.trailerHlsUrl,
    required this.trailerStatus,
    required this.publishedOn,
    required this.videoDuration,
    required this.description,
    required this.genreName,
    required this.videoCategoryName,
    required this.isSubscribed,
    required this.videoArea,
  });

  String? title;
  String? slug;
  String? thumbnailImage;
  String? posterImage;
  int? isFavourite;
  int? isLive;
  int? viewCount;
  int? isPremium;
  int? price;
  String? trailerHlsUrl;
  String? trailerStatus;
  DateTime? publishedOn;
  String? videoDuration;
  String? description;
  String? genreName;
  String? videoCategoryName;
  int? isSubscribed;
  String? videoArea;

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    thumbnailImage: json["thumbnail_image"] == null ? null : json["thumbnail_image"],
    posterImage: json["poster_image"] == null ? null : json["poster_image"],
    isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
    isLive: json["is_live"] == null ? null : json["is_live"],
    viewCount: json["view_count"] == null ? null : json["view_count"],
    isPremium: json["is_premium"] == null ? null : json["is_premium"],
    price: json["price"] == null ? null : json["price"],
    trailerHlsUrl: json["trailer_hls_url"] == null ? null : json["trailer_hls_url"],
    trailerStatus: json["trailer_status"] == null ? null : json["trailer_status"],
    publishedOn: json["published_on"] == null ? null : DateTime.parse(json["published_on"]),
    videoDuration: json["video_duration"] == null ? null : json["video_duration"],
    description: json["description"] == null ? null : json["description"],
    genreName: json["genre_name"] == null ? null : json["genre_name"],
    videoCategoryName: json["video_category_name"] == null ? null : json["video_category_name"],
    isSubscribed: json["is_subscribed"] == null ? null : json["is_subscribed"],
    videoArea: json["video_area"] == null ? null : json["video_area"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "thumbnail_image": thumbnailImage == null ? null : thumbnailImage,
    "poster_image": posterImage == null ? null : posterImage,
    "is_favourite": isFavourite == null ? null : isFavourite,
    "is_live": isLive == null ? null : isLive,
    "view_count": viewCount == null ? null : viewCount,
    "is_premium": isPremium == null ? null : isPremium,
    "price": price == null ? null : price,
    "trailer_hls_url": trailerHlsUrl == null ? null : trailerHlsUrl,
    "trailer_status": trailerStatus == null ? null : trailerStatus,
    "published_on": publishedOn == null ? null : "${publishedOn!.year.toString().padLeft(4, '0')}-${publishedOn!.month.toString().padLeft(2, '0')}-${publishedOn!.day.toString().padLeft(2, '0')}",
    "video_duration": videoDuration == null ? null : videoDuration,
    "description": description == null ? null : description,
    "genre_name": genreName == null ? null : genreName,
    "video_category_name": videoCategoryName == null ? null : videoCategoryName,
    "is_subscribed": isSubscribed == null ? null : isSubscribed,
    "video_area": videoArea == null ? null : videoArea,
  };
}

class PaymentInfo {
  PaymentInfo({
    required this.isBought,
    required this.transactionId,
    required this.userViewCount,
    required this.globalViewCount,
  });

  int? isBought;
  dynamic transactionId;
  dynamic userViewCount;
  dynamic globalViewCount;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
    isBought: json["is_bought"] == null ? null : json["is_bought"],
    transactionId: json["transaction_id"],
    userViewCount: json["user_view_count"],
    globalViewCount: json["global_view_count"],
  );

  Map<String, dynamic> toJson() => {
    "is_bought": isBought == null ? null : isBought,
    "transaction_id": transactionId,
    "user_view_count": userViewCount,
    "global_view_count": globalViewCount,
  };
}

class VideoInfo {
  VideoInfo({
    required this.episodeOrder,
    required this.title,
    required this.slug,
    required this.description,
    required this.streamId,
    required this.sourceUrl,
    required this.thumbnailImage,
    required this.videoDuration,
    required this.hlsPlaylistUrl,
    required this.isLive,
    required this.scheduledStartTime,
    required this.publishedOn,
    required this.presenter,
    required this.isPremium,
    required this.posterImage,
    required this.viewCount,
    required this.isFavourite,
    required this.videoCategoryName,
    required this.isLike,
    required this.isDislike,
    required this.likeCount,
    required this.dislikeCount,
    required this.autoPlay,
    required this.seasonName,
    required this.seasonId,
    required this.subtitle,
    required this.passphrase,
    required this.spriteImage,
    required this.adsUrl,
    required this.commentsCount,
    required this.price,
    required this.globalVideoViewCount,
    required this.videoCategorySlug,
    required this.parentCategorySlug,
    required this.trailerHlsUrl,
    required this.trailerStatus,
    required this.videoDurationSeconds,
    required this.isRestricted,
    required this.isCouponEnabled,
    required this.seconds,
    required this.genreName,
    required this.isSubscribed,
    required this.videoArea,
    required this.tags,
  });

  dynamic episodeOrder;
  String? title;
  String? slug;
  String? description;
  dynamic streamId;
  dynamic sourceUrl;
  String? thumbnailImage;
  String? videoDuration;
  String? hlsPlaylistUrl;
  int? isLive;
  String? scheduledStartTime;
  DateTime? publishedOn;
  dynamic presenter;
  int? isPremium;
  String? posterImage;
  int? viewCount;
  int? isFavourite;
  String? videoCategoryName;
  int? isLike;
  int? isDislike;
  int? likeCount;
  int? dislikeCount;
  int? autoPlay;
  dynamic seasonName;
  String? seasonId;
  Subtitle? subtitle;
  String? passphrase;
  String? spriteImage;
  String? adsUrl;
  int? commentsCount;
  int? price;
  int? globalVideoViewCount;
  String? videoCategorySlug;
  String? parentCategorySlug;
  dynamic trailerHlsUrl;
  dynamic trailerStatus;
  int? videoDurationSeconds;
  int? isRestricted;
  int? isCouponEnabled;
  dynamic seconds;
  String? genreName;
  int? isSubscribed;
  dynamic videoArea;
  List<dynamic>? tags;

  factory VideoInfo.fromJson(Map<String, dynamic> json) => VideoInfo(
    episodeOrder: json["episode_order"],
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    description: json["description"] == null ? null : json["description"],
    streamId: json["stream_id"],
    sourceUrl: json["source_url"],
    thumbnailImage: json["thumbnail_image"] == null ? null : json["thumbnail_image"],
    videoDuration: json["video_duration"] == null ? null : json["video_duration"],
    hlsPlaylistUrl: json["hls_playlist_url"] == null ? null : json["hls_playlist_url"],
    isLive: json["is_live"] == null ? null : json["is_live"],
    scheduledStartTime: json["scheduledStartTime"] == null ? null : json["scheduledStartTime"],
    publishedOn: json["published_on"] == null ? null : DateTime.parse(json["published_on"]),
    presenter: json["presenter"],
    isPremium: json["is_premium"] == null ? null : json["is_premium"],
    posterImage: json["poster_image"] == null ? null : json["poster_image"],
    viewCount: json["view_count"] == null ? null : json["view_count"],
    isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
    videoCategoryName: json["video_category_name"] == null ? null : json["video_category_name"],
    isLike: json["is_like"] == null ? null : json["is_like"],
    isDislike: json["is_dislike"] == null ? null : json["is_dislike"],
    likeCount: json["like_count"] == null ? null : json["like_count"],
    dislikeCount: json["dislike_count"] == null ? null : json["dislike_count"],
    autoPlay: json["auto_play"] == null ? null : json["auto_play"],
    seasonName: json["season_name"],
    seasonId: json["season_id"] == null ? null : json["season_id"],
    subtitle: json["subtitle"] == null ? null : Subtitle.fromJson(json["subtitle"]),
    passphrase: json["passphrase"] == null ? null : json["passphrase"],
    spriteImage: json["sprite_image"] == null ? null : json["sprite_image"],
    adsUrl: json["ads_url"] == null ? null : json["ads_url"],
    commentsCount: json["comments_count"] == null ? null : json["comments_count"],
    price: json["price"] == null ? null : json["price"],
    globalVideoViewCount: json["global_video_view_count"] == null ? null : json["global_video_view_count"],
    videoCategorySlug: json["video_category_slug"] == null ? null : json["video_category_slug"],
    parentCategorySlug: json["parent_category_slug"] == null ? null : json["parent_category_slug"],
    trailerHlsUrl: json["trailer_hls_url"],
    trailerStatus: json["trailer_status"],
    videoDurationSeconds: json["video_duration_seconds"] == null ? null : json["video_duration_seconds"],
    isRestricted: json["is_restricted"] == null ? null : json["is_restricted"],
    isCouponEnabled: json["is_coupon_enabled"] == null ? null : json["is_coupon_enabled"],
    seconds: json["seconds"],
    genreName: json["genre_name"] == null ? null : json["genre_name"],
    isSubscribed: json["is_subscribed"] == null ? null : json["is_subscribed"],
    videoArea: json["video_area"],
    tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "episode_order": episodeOrder,
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "description": description == null ? null : description,
    "stream_id": streamId,
    "source_url": sourceUrl,
    "thumbnail_image": thumbnailImage == null ? null : thumbnailImage,
    "video_duration": videoDuration == null ? null : videoDuration,
    "hls_playlist_url": hlsPlaylistUrl == null ? null : hlsPlaylistUrl,
    "is_live": isLive == null ? null : isLive,
    "scheduledStartTime": scheduledStartTime == null ? null : scheduledStartTime,
    "published_on": publishedOn == null ? null : "${publishedOn!.year.toString().padLeft(4, '0')}-${publishedOn!.month.toString().padLeft(2, '0')}-${publishedOn!.day.toString().padLeft(2, '0')}",
    "presenter": presenter,
    "is_premium": isPremium == null ? null : isPremium,
    "poster_image": posterImage == null ? null : posterImage,
    "view_count": viewCount == null ? null : viewCount,
    "is_favourite": isFavourite == null ? null : isFavourite,
    "video_category_name": videoCategoryName == null ? null : videoCategoryName,
    "is_like": isLike == null ? null : isLike,
    "is_dislike": isDislike == null ? null : isDislike,
    "like_count": likeCount == null ? null : likeCount,
    "dislike_count": dislikeCount == null ? null : dislikeCount,
    "auto_play": autoPlay == null ? null : autoPlay,
    "season_name": seasonName,
    "season_id": seasonId == null ? null : seasonId,
    "subtitle": subtitle == null ? null : subtitle!.toJson(),
    "passphrase": passphrase == null ? null : passphrase,
    "sprite_image": spriteImage == null ? null : spriteImage,
    "ads_url": adsUrl == null ? null : adsUrl,
    "comments_count": commentsCount == null ? null : commentsCount,
    "price": price == null ? null : price,
    "global_video_view_count": globalVideoViewCount == null ? null : globalVideoViewCount,
    "video_category_slug": videoCategorySlug == null ? null : videoCategorySlug,
    "parent_category_slug": parentCategorySlug == null ? null : parentCategorySlug,
    "trailer_hls_url": trailerHlsUrl,
    "trailer_status": trailerStatus,
    "video_duration_seconds": videoDurationSeconds == null ? null : videoDurationSeconds,
    "is_restricted": isRestricted == null ? null : isRestricted,
    "is_coupon_enabled": isCouponEnabled == null ? null : isCouponEnabled,
    "seconds": seconds,
    "genre_name": genreName == null ? null : genreName,
    "is_subscribed": isSubscribed == null ? null : isSubscribed,
    "video_area": videoArea,
    "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
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
