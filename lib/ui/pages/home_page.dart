import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_apps/models.dart';
import 'package:get_apps/get_apps.dart';
import 'package:provider/provider.dart';
import 'package:zero_launcher/main.dart';
import 'package:zero_launcher/models/app_model.dart';
import 'package:zero_launcher/services/apps_service.dart';

import '../widgets/app_icon.dart';
import '../widgets/clock.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
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
      drawer: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Drawer(
          backgroundColor: Colors.black54,
          width: MediaQuery.of(context).size.width,
          shape: BeveledRectangleBorder(),
          child: Consumer<AppsService>(
            builder: (context, appsService, child) {
              if (appsService.apps != null) {
                final data = appsService.apps as List<AppModel>;
                int i = 0;
                return ListView.builder(
                  itemExtent: 110,
                  itemCount:
                      (data.length ~/ 3) + (data.length % 3 == 0 ? 0 : 1),
                  itemBuilder: (context, index) {
                    i = index * 3;
                    if (index < data.length ~/ 3) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppClickableIcon(appInfo: data[i]),
                            Transform.translate(
                              offset: const Offset(0, -40),
                              child: AppClickableIcon(appInfo: data[i + 1]),
                            ),
                            AppClickableIcon(appInfo: data[i + 2]),
                          ],
                        ),
                      );
                    }
                    if (data.length % 3 == 1) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -40),
                            child: AppClickableIcon(appInfo: data[i]),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppClickableIcon(appInfo: data[i]),
                        Transform.translate(
                          offset: const Offset(0, -40),
                          child: AppClickableIcon(appInfo: data[i + 1]),
                        ),
                        const SizedBox(width: 80, height: 80),
                      ],
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                _homePageKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.ac_unit, color: Colors.white),
            ),
            const CustomClock(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
