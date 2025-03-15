import 'package:flutter/material.dart';
import 'package:get_apps/get_apps.dart';
import 'package:zero_launcher/models/app_model.dart';

class AppsService with ChangeNotifier {
  late GetApps _getApps;
  List<AppModel>? apps;

  AppsService() {
    _getApps = GetApps();
    loadApps();
    listenPackageActions();
  }

  loadApps() async {
    apps =
        (await _getApps.getApps())
            .map((appInfo) => AppModel.fromAppInfo(appInfo))
            .toList();
    notifyListeners();
  }

  listenPackageActions() {
    _getApps.appActionReceiver().forEach((action) {
      if (action.action == "added") {
        loadApps();
      } else if (apps != null) {
        apps!.removeWhere((app) => app.packageName == action.packageName);
        notifyListeners();
      }
    });
  }
}
