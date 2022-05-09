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
  Responses? response;

  factory GetMovieDetails.fromJson(Map<String, dynamic> json) => GetMovieDetails(
    error: json["error"] == null ? null : json["error"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["response"] == null ? null : Responses.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "statusCode": statusCode == null ? null : statusCode,
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "response": response == null ? null : response!.toJson(),
  };
}

class Responses {
  Responses({
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

  factory Responses.fromJson(Map<String, dynamic> json) => Responses(
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

class PurpleDatum {
  PurpleDatum({
    required this.id,
    required this.comment,
    required this.parentId,
    required this.userType,
    required this.customerId,
    required this.createdAt,
    required this.replyComment,
    required this.customer,
  });

  String? id;
  String? comment;
  String? parentId;
  String? userType;
  int customerId;
  String? createdAt;
  Comments? replyComment;
  Customer? customer;

  factory PurpleDatum.fromJson(Map<String, dynamic> json) => PurpleDatum(
    id: json["_id"] == null ? null : json["_id"],
    comment: json["comment"] == null ? null : json["comment"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    userType: json["user_type"] == null ? null : json["user_type"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    replyComment: json["reply_comment"] == null ? null : Comments.fromJson(json["reply_comment"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "comment": comment == null ? null : comment,
    "parent_id": parentId == null ? null : parentId,
    "user_type": userType == null ? null : userType,
    "customer_id": customerId == null ? null : customerId,
    "created_at": createdAt == null ? null : createdAt,
    "reply_comment": replyComment == null ? null : replyComment!.toJson(),
    "customer": customer == null ? null : customer!.toJson(),
  };
}

class ReplyComment {
  ReplyComment({
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
  List<PurpleDatum>? data;
  String? firstPageUrl;
  int from;
  int lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory ReplyComment.fromJson(Map<String, dynamic> json) => ReplyComment(
    currentPage: json["current_page"] ?? 0,
    data: json["data"] == null ? null : List<PurpleDatum>.from(json["data"].map((x) => PurpleDatum.fromJson(x))),
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

class CommentsDatum {
  CommentsDatum({
    required this.id,
    required this.comment,
    required this.userType,
    required this.customerId,
    required this.isActive,
    required this.createdAt,
    required this.replyComment,
    required this.customer,
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

  String? id;
  String? comment;
  String? userType;
  int customerId;
  int isActive;
  String? createdAt;
  ReplyComment? replyComment;
  Customer? customer;
  String? title;
  String? slug;
  String? thumbnailImage;
  String? posterImage;
  int isFavourite;
  int isLive;
  int viewCount;
  int isPremium;
  int price;
  dynamic trailerHlsUrl;
  dynamic trailerStatus;
  DateTime? publishedOn;
  String? videoDuration;
  String? description;
  String? genreName;
  String? videoCategoryName;
  int isSubscribed;
  dynamic videoArea;

  factory CommentsDatum.fromJson(Map<String, dynamic> json) => CommentsDatum(
    id: json["_id"] ?? "",
    comment: json["comment"] ?? "",
    userType: json["user_type"] ?? "",
    customerId: json["customer_id"] ?? 0,
    isActive: json["is_active"] ?? 0,
    createdAt: json["created_at"] ?? "",
    replyComment: json["reply_comment"] == null ? null : ReplyComment.fromJson(json["reply_comment"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    title: json["title"] ?? "",
    slug: json["slug"] ?? "",
    thumbnailImage: json["thumbnail_image"] ?? "",
    posterImage: json["poster_image"] ?? "",
    isFavourite: json["is_favourite"] ?? 0,
    isLive: json["is_live"] ?? 0,
    viewCount: json["view_count"] ?? 0,
    isPremium: json["is_premium"] ?? 0,
    price: json["price"] ?? 0,
    trailerHlsUrl: json["trailer_hls_url"] ?? "",
    trailerStatus: json["trailer_status"] ?? "",
    publishedOn: json["published_on"] == null ? null : DateTime.parse(json["published_on"]),
    videoDuration: json["video_duration"] ?? "",
    description: json["description"] ?? "",
    genreName: json["genre_name"] ?? "",
    videoCategoryName: json["video_category_name"] ?? "",
    isSubscribed: json["is_subscribed"] ?? 0,
    videoArea: json["video_area"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "comment": comment == null ? null : comment,
    "user_type": userType == null ? null : userType,
    "customer_id": customerId == null ? null : customerId,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt,
    "reply_comment": replyComment == null ? null : replyComment!.toJson(),
    "customer": customer == null ? null : customer!.toJson(),
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "thumbnail_image": thumbnailImage == null ? null : thumbnailImage,
    "poster_image": posterImage == null ? null : posterImage,
    "is_favourite": isFavourite == null ? null : isFavourite,
    "is_live": isLive == null ? null : isLive,
    "view_count": viewCount == null ? null : viewCount,
    "is_premium": isPremium == null ? null : isPremium,
    "price": price == null ? null : price,
    "trailer_hls_url": trailerHlsUrl,
    "trailer_status": trailerStatus,
    "published_on": publishedOn == null ? null : "${publishedOn!.year.toString().padLeft(4, '0')}-${publishedOn!.month.toString().padLeft(2, '0')}-${publishedOn!.day.toString().padLeft(2, '0')}",
    "video_duration": videoDuration == null ? null : videoDuration,
    "description": description == null ? null : description,
    "genre_name": genreName == null ? null : genreName,
    "video_category_name": videoCategoryName == null ? null : videoCategoryName,
    "is_subscribed": isSubscribed == null ? null : isSubscribed,
    "video_area": videoArea,
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

  int currentPage;
  List<CommentsDatum>? data;
  String? firstPageUrl;
  int from;
  int lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    currentPage: json["current_page"] ?? 0,
    data: json["data"] == null ? null : List<CommentsDatum>.from(json["data"].map((x) => CommentsDatum.fromJson(x))),
    firstPageUrl: json["first_page_url"] ?? "",
    from: json["from"] ?? 0,
    lastPage: json["last_page"]?? 0,
    lastPageUrl: json["last_page_url"] ?? "",
    nextPageUrl: json["next_page_url"] ?? "",
    path: json["path"] ?? "",
    perPage: json["per_page"] ?? 0,
    prevPageUrl: json["prev_page_url"] ?? "",
    to: json["to"] ?? 0,
    total: json["total"] ?? "",
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

class Customer {
  Customer({
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.age,
    required this.profilePicture,
    required this.isLocked,
    required this.notifyEmail,
    required this.countryCode,
    required this.iso,
    required this.customerPaymentId,
    required this.subscriptionType,
    required this.customerStripeId,
    required this.appleAuthId,
    required this.appleUserId,
  });

  String? name;
  String? email;
  String? phone;
  String? dob;
  int age;
  String? profilePicture;
  String? isLocked;
  int notifyEmail;
  String? countryCode;
  dynamic iso;
  String? customerPaymentId;
  String? subscriptionType;
  String? customerStripeId;
  dynamic appleAuthId;
  dynamic appleUserId;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    dob: json["dob"] == null ? null : json["dob"],
    age: json["age"] == null ? null : json["age"],
    profilePicture: json["profile_picture"] == null ? null : json["profile_picture"],
    isLocked: json["is_locked"] == null ? null : json["is_locked"],
    notifyEmail: json["notify_email"] == null ? null : json["notify_email"],
    countryCode: json["country_code"] == null ? null : json["country_code"],
    iso: json["iso"],
    customerPaymentId: json["customer_payment_id"] == null ? null : json["customer_payment_id"],
    subscriptionType: json["subscription_type"] == null ? null : json["subscription_type"],
    customerStripeId: json["customer_stripe_id"] == null ? null : json["customer_stripe_id"],
    appleAuthId: json["apple_auth_id"],
    appleUserId: json["apple_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "dob": dob == null ? null : dob,
    "age": age == null ? null : age,
    "profile_picture": profilePicture == null ? null : profilePicture,
    "is_locked": isLocked == null ? null : isLocked,
    "notify_email": notifyEmail == null ? null : notifyEmail,
    "country_code": countryCode == null ? null : countryCode,
    "iso": iso,
    "customer_payment_id": customerPaymentId == null ? null : customerPaymentId,
    "subscription_type": subscriptionType == null ? null :subscriptionType,
    "customer_stripe_id": customerStripeId == null ? null : customerStripeId,
    "apple_auth_id": appleAuthId,
    "apple_user_id": appleUserId,
  };
}



class PaymentInfo {
  PaymentInfo({
    required this.isBought,
    required this.transactionId,
    required this.userViewCount,
    required this.globalViewCount,
  });

  int isBought;
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
  String? presenter;
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
  int? seasonId;
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
  String? videoArea;
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
    presenter: json["presenter"] == null ? null : json["presenter"],
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
    videoArea: json["video_area"] == null ? null : json["video_area"],
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
    "presenter": presenter == null ? null : presenter,
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
    "video_area": videoArea == null ? null : videoArea,
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

  Map<String?, dynamic> toJson() => {
    "base_url": baseUrl == null ? null : baseUrl,
    "subtitle_list": subtitleList == null ? null : List<dynamic>.from(subtitleList!.map((x) => x)),
  };
}


