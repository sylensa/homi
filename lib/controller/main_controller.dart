import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:homi/helper/helper.dart';
import 'package:homi/services/get_movie_details.dart';
import 'package:path/path.dart';

import 'package:homi/helper/widgets.dart';
import 'package:homi/model/download_update.dart';
import 'package:homi/model/package_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class MainController {
  BuildContext context;
  DownloadUpdate provider;

  MainController(this.context, this.provider,);

  void setSubscriptions() {
    provider.setSubscriptions();
  }






  downloadSubscription(List items,
      Function(bool success) finallyCallback) async {
    bool downloadSuccessful = false;
    Responses? currentItem = null;
    List listDownloadedMovies = [];
    listDownloadedMovies = await getPref("listDownloadedMovies",type: "list") ?? [];
    try {
      provider.setDownloading(true);
      Wakelock.enable();
      showLoaderDialog(context, message: "starting downloads");
      Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
      for (int i = 0; i < items.length; i++) {
        currentItem = items[i];
        currentItem!.isDownloading = true;
        provider.setState();
        String filename = currentItem.videoInfo!.title!;
        FileDownloader fileDownloader = FileDownloader(currentItem.videoInfo!.hlsPlaylistUrl!,provider, filename: "${currentItem.videoInfo!.slug!}.mp4");

        print(context);
        provider.updateMessage("downloading $filename");
        await fileDownloader.downloadFile((percentage) {
          print("download: ${percentage}%");
          print(context);
          provider.updatePercentage(percentage);
        });

        provider.updateMessage("saving $filename");
        provider.updateMessage("saving $filename images");
        provider.doneDownlaod("$filename ...  done.");
        currentItem.isDownloading = false;
        listDownloadedMovies.add(jsonEncode(currentItem));
        await setPref("listDownloadedMovies",listDownloadedMovies,type: "list");
        provider.setState();
      }
      provider.setNotificationUp(false, 0);
      downloadSuccessful = true;
    } on SocketException catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      // showNoConnectionToast(context);
    } catch (m, e) {
      provider.updateMessage("$m");
      provider.setDownloading(false);
      if (currentItem != null) {
        // currentItem.isDownloading = false;
        provider.setState();
      }

      print("Error>>>>>>>> download failed");
      print(m);
      print(e);
      // goTo(context, DownloadFailed(),replace: true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download failed")));
    } finally {
      Wakelock.disable();

      provider.setDownloading(false);
      provider.clearDownloads();

      finallyCallback(downloadSuccessful);
    }
  }
  File getImageFile(String name) {
    File file = new File(join("applicationDirPath", name));
    return file;
  }

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<File> saveImageToDir(var _byteImage, String name) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = new File(join(documentDirectory.path, name));
    print('writing to file .................. .');
    return await file.writeAsBytes(_byteImage);
  }
}
