import 'package:flutter/cupertino.dart';

enum LauncherStyleType{
  plainLauncher,
  keypadLauncher
}

extension LauncherStyle on LauncherStyleType{
  static LauncherStyleType fromInt(int styleCode){
    switch (styleCode){
      case 0:
        return LauncherStyleType.plainLauncher;
      case 1:
        return LauncherStyleType.keypadLauncher;
    }
    throw ErrorDescription("Unknown Launcher Style!");
  }
}