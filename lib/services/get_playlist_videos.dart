// To parse this JSON data, do
//
//     final getPlaylistMovies = getPlaylistMoviesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetPlaylistMovies getPlaylistMoviesFromJson(String? str) => GetPlaylistMovies.fromJson(json.decode(str!));

String? getPlaylistMoviesToJson(GetPlaylistMovies data) => json.encode(data.toJson());

class GetPlaylistMovies {
  GetPlaylistMovies({
    required this.error,
    required this.statusCode,
    required this.status,
    required this.message,
    required this.response,
  });

  bool error;
  String? statusCode;
  String? status;
  String? message;
  PlaylistMovieResponse? response;

  factory GetPlaylistMovies.fromJson(Map<String, dynamic> json) => GetPlaylistMovies(
    error: json["error"] == null ? null : json["error"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["response"] == null ? null : PlaylistMovieResponse.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "statusCode": statusCode == null ? null : statusCode,
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "response": response == null ? null : response!.toJson(),
  };
}

class PlaylistMovieResponse {
  PlaylistMovieResponse({
    required this.playlistInfo,
    required this.playlistVideos,
  });

  PlaylistInfo? playlistInfo;
  PlaylistVideos? playlistVideos;

  factory PlaylistMovieResponse.fromJson(Map<String, dynamic> json) => PlaylistMovieResponse(
    playlistInfo: json["playlist_info"] == null ? null : PlaylistInfo.fromJson(json["playlist_info"]),
    playlistVideos: json["playlist_videos"] == null ? null : PlaylistVideos.fromJson(json["playlist_videos"]),
  );

  Map<String, dynamic> toJson() => {
    "playlist_info": playlistInfo == null ? null : playlistInfo!.toJson(),
    "playlist_videos": playlistVideos == null ? null : playlistVideos!.toJson(),
  };
}

class PlaylistInfo {
  PlaylistInfo({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.isAdded,
    required this.videoCount,
    required this.posterImage,
  });

  String? id;
  String? name;
  DateTime? createdAt;
  int? isAdded;
  int? videoCount;
  String? posterImage;

  factory PlaylistInfo.fromJson(Map<String, dynamic> json) => PlaylistInfo(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isAdded: json["is_added"] == null ? null : json["is_added"],
    videoCount: json["video_count"] == null ? null : json["video_count"],
    posterImage: json["poster_image"] == null ? null : json["poster_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "is_added": isAdded == null ? null : isAdded,
    "video_count": videoCount == null ? null : videoCount,
    "poster_image": posterImage == null ? null : posterImage,
  };
}

class PlaylistVideos {
  PlaylistVideos({
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
  List<Datum>? data;
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

  factory PlaylistVideos.fromJson(Map<String, dynamic> json) => PlaylistVideos(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    required this.id,
    required this.playlistId,
    required this.videoId,
    required this.screenId,
    required this.isActive,
    required this.createdAt,
    required this.video,
  });

  String? id;
  String? playlistId;
  String? videoId;
  String? screenId;
  int? isActive;
  DateTime? createdAt;
  Video? video;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"] == null ? null : json["_id"],
    playlistId: json["playlist_id"] == null ? null : json["playlist_id"],
    videoId: json["video_id"] == null ? null : json["video_id"],
    screenId: json["screen_id"] == null ? null : json["screen_id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    video: json["video"] == null ? null : Video.fromJson(json["video"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "playlist_id": playlistId == null ? null : playlistId,
    "video_id": videoId == null ? null : videoId,
    "screen_id": screenId == null ? null : screenId,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "video": video == null ? null : video!.toJson(),
  };
}

class Video {
  Video({
    required this.title,
    required this.slug,
    required this.description,
    required this.thumbnailImage,
    required this.hlsPlaylistUrl,
    required this.isFavourite,
    required this.collection,
    required this.posterImage,
    required this.isLive,
    required this.scheduledStartTime,
    required this.isPremium,
    required this.price,
    required this.genreName,
    required this.videoCategoryName,
    required this.isSubscribed,
  });

  String? title;
  String? slug;
  String? description;
  String? thumbnailImage;
  String? hlsPlaylistUrl;
  int? isFavourite;
  Collection? collection;
  String? posterImage;
  int? isLive;
  String? scheduledStartTime;
  int? isPremium;
  String? price;
  String? genreName;
  String? videoCategoryName;
  int? isSubscribed;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    description: json["description"] == null ? null : json["description"],
    thumbnailImage: json["thumbnail_image"] == null ? null : json["thumbnail_image"],
    hlsPlaylistUrl: json["hls_playlist_url"] == null ? null : json["hls_playlist_url"],
    isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
    collection: json["collection"] == null ? null : Collection.fromJson(json["collection"]),
    posterImage: json["poster_image"] == null ? null : json["poster_image"],
    isLive: json["is_live"] == null ? null : json["is_live"],
    scheduledStartTime: json["scheduledStartTime"] == null ? null : json["scheduledStartTime"],
    isPremium: json["is_premium"] == null ? null : json["is_premium"],
    price: json["price"] == null ? null : json["price"].toString(),
    genreName: json["genre_name"] == null ? null : json["genre_name"],
    videoCategoryName: json["video_category_name"] == null ? null : json["video_category_name"],
    isSubscribed: json["is_subscribed"] == null ? null : json["is_subscribed"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "description": description == null ? null : description,
    "thumbnail_image": thumbnailImage == null ? null : thumbnailImage,
    "hls_playlist_url": hlsPlaylistUrl == null ? null : hlsPlaylistUrl,
    "is_favourite": isFavourite == null ? null : isFavourite,
    "collection": collection == null ? null : collection!.toJson(),
    "poster_image": posterImage == null ? null : posterImage,
    "is_live": isLive == null ? null : isLive,
    "scheduledStartTime": scheduledStartTime == null ? null : scheduledStartTime,
    "is_premium": isPremium == null ? null : isPremium,
    "price": price == null ? null : price,
    "genre_name": genreName == null ? null : genreName,
    "video_category_name": videoCategoryName == null ? null : videoCategoryName,
    "is_subscribed": isSubscribed == null ? null : isSubscribed,
  };
}

class Collection {
  Collection({
    required this.id,
    required this.collectionId,
    required this.name,
    required this.slug,
    required this.groupImage,
    required this.isActive,
    required this.creatorId,
    required this.updatorId,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int? id;
  dynamic collectionId;
  String? name;
  String? slug;
  dynamic groupImage;
  int? isActive;
  int? creatorId;
  int? updatorId;
  String? order;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    id: json["id"] == null ? null : json["id"],
    collectionId: json["collection_id"],
    name: json["name"] == null ? null : json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    groupImage: json["group_image"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    creatorId: json["creator_id"] == null ? null : json["creator_id"],
    updatorId: json["updator_id"] == null ? null : json["updator_id"],
    order: json["order"] == null ? null : json["order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "collection_id": collectionId,
    "name": name == null ? null : name,
    "slug": slug == null ? null : slug,
    "group_image": groupImage,
    "is_active": isActive == null ? null : isActive,
    "creator_id": creatorId == null ? null : creatorId,
    "updator_id": updatorId == null ? null : updatorId,
    "order": order == null ? null : order,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "pivot": pivot == null ? null : pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    required this.videoId,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
  });

  int? videoId;
  int? groupId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    videoId: json["video_id"] == null ? null : json["video_id"],
    groupId: json["group_id"] == null ? null : json["group_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId == null ? null : videoId,
    "group_id": groupId == null ? null : groupId,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
