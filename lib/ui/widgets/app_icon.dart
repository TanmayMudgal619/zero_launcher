import 'package:flutter/material.dart';
import 'package:get_apps/models.dart';
import 'package:get_apps/get_apps.dart';
import 'package:zero_launcher/models/app_model.dart';

class AppClickableIcon extends StatelessWidget {
  final AppModel appInfo;
  const AppClickableIcon({Key? key, required this.appInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GetApps().openApp(appInfo.packageName),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black45, spreadRadius: 5, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: appInfo.appIcon)
            ),
          ),
        ),
      ),
    );
  }
}
