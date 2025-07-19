import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_launcher/models/app_model.dart';
import 'package:zero_launcher/services/apps_service.dart';

import '../widgets/app_icon.dart';
import '../widgets/clock.dart';

class PlainLauncher extends StatefulWidget {
  const PlainLauncher({super.key});

  @override
  State<PlainLauncher> createState() => _PlainLauncherState();
}

class _PlainLauncherState extends State<PlainLauncher> {
  final GlobalKey<ScaffoldState> _homePageKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homePageKey,
      backgroundColor: const Color(0xff014b4c),
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomClock(),
              const SizedBox(height: 20),
              Consumer<AppsService>(
                builder: (context, appsService, child) {
                  return FutureBuilder(future: appsService.apps, builder: (context, snapshot) {
                    if (snapshot.hasError){
                      return Center(child: Text("Can't load apps, contact the developers!"));
                    }
                    if (snapshot.hasData){
                      var apps = snapshot.data as List<AppModel>;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10
                          ),
                          children: apps.map((app) => AppClickableIcon(appInfo: app)).toList(),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
