import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_apps/get_apps.dart';
import 'package:provider/provider.dart';
import 'package:zero_launcher/models/app_model.dart';
import 'package:zero_launcher/services/apps_service.dart';

import '../widgets/clock.dart';

class KeypadLauncher extends StatefulWidget {
  const KeypadLauncher({super.key});

  @override
  State<KeypadLauncher> createState() => _KeypadLauncherState();
}

class _KeypadLauncherState extends State<KeypadLauncher> {
  final keys = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
    "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#", "."
  ];
  final GlobalKey<ScaffoldState> _homePageKey = GlobalKey();
  late Map<String, List<AppModel>> appGroupingByFirstCharacter;
  String selectedCharacter = "A";

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const CustomClock(),
                const SizedBox(height: 20),
              ],
            ),
           Consumer<AppsService>(builder: (context, appService, _) {
             return FutureBuilder(future: appService.apps, builder: (context, snapshot){
               if (snapshot.hasError){
                 return Center(child: Text("Can't load apps, contact the developers!"));
               }
               if (snapshot.hasData){
                 groupAppsByFirstCharacter(snapshot.data as List<AppModel>);
                 var apps = appGroupingByFirstCharacter[selectedCharacter] ?? [];
                 return Column(
                   children: [
                     ConstrainedBox(
                       constraints: BoxConstraints(
                         maxHeight: 300
                       ),
                       child: GridView(
                         shrinkWrap: true,
                         padding: EdgeInsets.zero,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,
                           crossAxisSpacing: 10,
                           mainAxisSpacing: 10,
                           childAspectRatio: 4,
                         ),
                         children: apps.map(
                           (app) => InkWell(
                             onTap: () => GetApps().openApp(app.packageName),
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                               child: Row(
                                 children: [
                                   Image.memory(app.appIcon.bytes),
                                   Expanded(
                                     child: Padding(
                                       padding: const EdgeInsets.only(left:10.0),
                                       child: Text(
                                         app.appName,
                                         style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
                                         maxLines: 1,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           )
                         ).toList(),
                       ),
                     ),
                     SizedBox(height: 10,),
                     Container(
                       color: Colors.black26,
                       child: GridView(
                         padding: EdgeInsets.zero,
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                         children: keys.map((key) => InkWell(
                           onTap: () => setState(() {
                             selectedCharacter = key;
                           }),
                           child: Center(
                             child: Text(
                               key,
                               style: TextStyle(fontWeight: FontWeight.bold),
                             )
                           ),
                         )).toList(),
                       ),
                     ),
                   ],
                 );
               }
               return CircularProgressIndicator();
             });
           }),
          ],
        ),
      ),
    );
  }

  void groupAppsByFirstCharacter(List<AppModel> apps){
    appGroupingByFirstCharacter = {
      "#": [],
      ".": []
    };
    for (var app in apps) {
      var firstCharacter = app.appName[0].toUpperCase();
      if (!keys.sublist(0, 26).contains(firstCharacter)){
        firstCharacter = "#";
      }
      appGroupingByFirstCharacter['.']!.add(app);
      if (appGroupingByFirstCharacter.containsKey(firstCharacter)){
        appGroupingByFirstCharacter[firstCharacter]!.add(app);
      } else{
        appGroupingByFirstCharacter[firstCharacter] = [app];
      }
    }
  }
}
