import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zero_launcher/services/settings_service.dart';
import 'package:zero_launcher/helpers/enums.dart';
import 'package:zero_launcher/ui/launcher_styles/keypad_launcher.dart';
import 'package:zero_launcher/ui/launcher_styles/plain_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsService>(
      builder: (context, settingsService, _){
        switch (settingsService.launcherStyle){
          case LauncherStyleType.plainLauncher:
            return PlainLauncher();
          case LauncherStyleType.keypadLauncher:
            return KeypadLauncher();
        }
      },
    );
  }
}
