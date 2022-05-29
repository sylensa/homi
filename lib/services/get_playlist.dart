// To parse this JSON data, do
//
//     final getPlaylist = getPlaylistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetPlaylist getPlaylistFromJson(String str) => GetPlaylist.fromJson(json.decode(str));

String getPlaylistToJson(GetPlaylist data) => json.encode(data.toJson());

class GetPlaylist {
  GetPlaylist({
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

  factory GetPlaylist.fromJson(Map<String, dynamic> json) => GetPlaylist(
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
    required this.myPlaylist,
  });

  MyPlaylist myPlaylist;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    myPlaylist: MyPlaylist.fromJson(json["my_playlist"]),
  );

  Map<String, dynamic> toJson() => {
    "my_playlist": myPlaylist.toJson(),
  };
}

class MyPlaylist {
  MyPlaylist({
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
  List<PlaylistData> data;
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

  factory MyPlaylist.fromJson(Map<String, dynamic> json) => MyPlaylist(
    currentPage: json["current_page"] ?? 0,
    data: List<PlaylistData>.from(json["data"].map((x) => PlaylistData.fromJson(x))),
    firstPageUrl: json["first_page_url"] ?? "",
    from: json["from"] ?? 0,
    lastPage: json["last_page"] ?? 0,
    lastPageUrl: json["last_page_url"] ?? "",
    nextPageUrl: json["next_page_url"] ?? "",
    path: json["path"] ?? "",
    perPage: json["per_page"]?? 0,
    prevPageUrl: json["prev_page_url"] ?? "",
    to: json["to"] ?? 0 ,
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

class PlaylistData {
  PlaylistData({
    required this.id,
    required this.name,
    required this.userId,
    required this.isActive,
    required this.screenId,
    required this.isAdmin,
    required this.slug,
    required this.createdAt,
    required this.isAdded,
    required this.videoCount,
    required this.posterImage,
  });

  String id;
  String name;
  String userId;
  int isActive;
  String screenId;
  int isAdmin;
  String slug;
  DateTime createdAt;
  int isAdded;
  int videoCount;
  String posterImage;

  factory PlaylistData.fromJson(Map<String, dynamic> json) => PlaylistData(
    id: json["_id"],
    name: json["name"],
    userId: json["user_id"],
    isActive: json["is_active"],
    screenId: json["screen_id"] ?? "",
    isAdmin: json["is_admin"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    isAdded: json["is_added"],
    videoCount: json["video_count"],
    posterImage: json["poster_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "user_id": userId,
    "is_active": isActive,
    "screen_id": screenId,
    "is_admin": isAdmin,
    "slug": slug,
    "created_at": createdAt.toIso8601String(),
    "is_added": isAdded,
    "video_count": videoCount,
    "poster_image": posterImage,
  };
}
