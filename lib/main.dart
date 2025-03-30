import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_launcher/services/apps_service.dart';
import 'package:zero_launcher/services/background_service.dart';
import 'package:zero_launcher/ui/pages/home_page.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppsService()),
      ChangeNotifierProvider(create: (_) => BackGroundColorsService())
    ],
    child: const App(),
  ),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xff014b4c),
        ),
      ),
      home: const HomeDrawer(),
    );
  }
}
