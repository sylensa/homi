import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:homi/model/download_update.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:permission_handler/permission_handler.dart';

class FileDownloader {
  final String url;
  String filename;
  DownloadUpdate provider;

  FileDownloader(this.url,this.provider, {required this.filename});

  downloadFile(Function(int percentage) publishSubject) async {
    PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted) {
      await Permission.storage.request();
      PermissionStatus permission = await Permission.storage.status;
      if (permission != PermissionStatus.granted) {
        return;
      }
    }
    Dio dio = Dio();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, filename);

    String? token = "";
    List res = url.split(".");
    res.remove("m3u8");
    print("join:${"${res.join("")}.mp4"}");
    // "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"
    return await dio.download(url, path,
        onReceiveProgress: (received, total) async{
          print("download: ${received},${total}%");
      if (total != -1) {
        int percentage = ((received / total) * 100).floor();
        // print("download: ${percentage}%");
        provider.updatePercentage(percentage);
        publishSubject(percentage);
      }

      if (Platform.isIOS) {
        // await ImageGallerySaver.saveFile(path,
        //     isReturnPathOfIOS: true);
        // String path =
        //     'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4';
        GallerySaver.saveVideo(path,albumName: filename).then((bool? success) {
          // print('Video is saved');

        });
      }

    });


  }
}

Future<bool> packageExist(String name) async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, name);

  final file = File(path);
  return await file.exists();
}

Future<String> readSubscriptionPlan(String name) async {
  try {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, name);

    final file = File(path);

    // Read the file
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    print("error:$e");
    return "error";
  }
}
