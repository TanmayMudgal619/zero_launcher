import 'package:flutter/material.dart';
import 'package:get_apps/get_apps.dart';
import 'package:zero_launcher/models/app_model.dart';

class AppsService with ChangeNotifier {
  late GetApps _getApps;
  late Future<List<AppModel>> apps;

  AppsService() {
    _getApps = GetApps();
    loadAppsAndNotify();
    listenPackageActions();
  }

  Future<List<AppModel>> loadApps() async{
    final apps = (await _getApps.getApps());
    return apps.map((appInfo) => AppModel.fromAppInfo(appInfo)).toList();
  }

  loadAppsAndNotify() {
    apps = loadApps();
    notifyListeners();
  }

  listenPackageActions() {
    _getApps.appActionReceiver().forEach((action) {
      loadAppsAndNotify();
    });
  }
}
