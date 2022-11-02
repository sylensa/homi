
import 'package:flutter/material.dart';

enum DownloadStatus { NONE, DOWNLOADING, DONE }

class DownloadUpdate with ChangeNotifier {
  DownloadUpdate(
      {this.message = "download beginning",
      this.percentage = 0,
      this.isDownloading = false,
      this.notificationUp = false});

  String? message;
  String? notificationMessage;
  int percentage;
  int newSubscriptions = 0;
  bool isDownloading;
  bool notificationUp;
  List<String> doneDownloads = [];

  String downloadCount = "";
  String downloadStatus = "";
  int currentPlanId = -1;

  void setSubscriptions() {
    notifyListeners();
  }


  setNotificationUp(bool state, int newSubs) {
    notificationUp = state;
    newSubscriptions = newSubs;
    notificationMessage = newSubs > 0
        ? "You have $newSubs new subscription${newSubs > 1 ? 's' : ''}"
        : newSubs < 0
            ? "You have lost a subscription"
            : "";
    notifyListeners();
  }

  void setDownloading(bool state) {
    isDownloading = state;
    notifyListeners();
  }

  void updateMessage(String message) {
    this.message = message;
    notifyListeners();
  }

  void updatePercentage(int percentage) {
    this.percentage = percentage;
    notifyListeners();
  }

  void doneDownlaod(String downloaded) {
    doneDownloads.add(downloaded);
    notifyListeners();
  }

  setState() {
    notifyListeners();
  }

  void clearDownloads() {
    currentPlanId = -1;
    doneDownloads.clear();
    notifyListeners();
  }
}
