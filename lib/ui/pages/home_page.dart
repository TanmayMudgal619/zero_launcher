import 'package:flutter/material.dart';
import 'package:get_apps/app_info.dart';
import 'package:get_apps/get_apps.dart';

import '../widgets/app_icon.dart';
import '../widgets/clock.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late Future<List<AppInfo>> _allUserApps;
  @override
  void initState() {
    _allUserApps = GetApps().getApps().then((apps) {
      return apps;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff014b4c),
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            const CustomClock(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<AppInfo>>(
                future: _allUserApps,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    int i = 0;
                    return ListView.builder(
                        itemExtent: 110,
                        itemCount: (data.length ~/ 3) + (data.length % 3 == 0 ? 0 : 1),
                        itemBuilder: (context, index){
                          i = index * 3;
                          if (index < data.length ~/ 3){
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
                          if (data.length % 3 == 1){
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Transform.translate(
                                  offset: const Offset(0, -40),
                                  child:AppClickableIcon(appInfo: data[i]),
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
                              const SizedBox(
                                width: 80,
                                height: 80,
                              ),
                            ],
                          );
                        }
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
