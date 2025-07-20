import 'package:flutter/widgets.dart';
import 'package:zero_launcher/helpers/enums.dart';

class SettingsService with ChangeNotifier{
  LauncherStyleType launcherStyle = LauncherStyleType.keypadLauncher;

  void switchStyle(){
    launcherStyle = LauncherStyle.fromInt((launcherStyle.index + 1) % LauncherStyleType.values.length);
    notifyListeners();
  }
}
