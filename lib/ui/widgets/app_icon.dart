import 'package:flutter/material.dart';
import 'package:get_apps/app_info.dart';
import 'package:get_apps/get_apps.dart';

class AppClickableIcon extends StatelessWidget {
  final AppInfo appInfo;
  const AppClickableIcon({Key? key, required this.appInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>GetApps().openApp(appInfo.appPackage),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                spreadRadius: 5,
                blurRadius: 10
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.memory(
            appInfo.appIcon,height : 80, width : 80,
          ),
        ),
      ),
    );
  }
}