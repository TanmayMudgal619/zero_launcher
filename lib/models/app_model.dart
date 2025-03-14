import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_apps/app_info.dart';

class AppModel{
  String appName;
  String packageName;
  MemoryImage appIcon;

  AppModel({
    required this.appName,
    required this.packageName,
    required this.appIcon
  });

  factory AppModel.fromAppInfo(AppInfo appInfo){
    return AppModel(
      appName: appInfo.appName,
      packageName: appInfo.appPackage,
      appIcon: MemoryImage(appInfo.appIcon)
    );
  }
}