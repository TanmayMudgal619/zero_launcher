import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_apps/app_info.dart';
import 'package:get_apps/get_apps.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Image.asset(
              "assets/imgs/bg.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(240, 0, 0, 0),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(25, 35, 5, 35),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(40, 255, 255, 255),
                              spreadRadius: 5,
                              blurRadius: 15,
                            )
                          ],
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.black,
                        ),
                        child: const CustomClock(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(240, 0, 0, 0),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: FutureBuilder<List<AppInfo>>(
                        future: GetApps().getUserApps(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.requireData;
                            return GridView.count(
                              scrollDirection: Axis.horizontal,
                              crossAxisCount: 4,
                              mainAxisSpacing: 30,
                              crossAxisSpacing: 30,
                              children: data
                                  .map((eachApp) => InkWell(
                                        onTap: () => GetApps()
                                            .runExternalApp(eachApp.appPackage),
                                        child: Image.memory(eachApp.appIcon),
                                      ))
                                  .toList(),
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomClock extends StatefulWidget {
  const CustomClock({super.key});

  @override
  State<CustomClock> createState() => _CustomClockState();
}

class _CustomClockState extends State<CustomClock> {
  String curTime = "";
  String curGreet = "Hi";
  @override
  void initState() {
    curTime = "${DateTime.now().hour}:${DateTime.now().minute}";
    Timer.periodic(const Duration(seconds: 1), (timer) => getCurTime());
    super.initState();
  }

  void getCurTime() {
    final d = DateTime.now();
    setState(() {
      if (d.hour < 12) {
        curGreet = "Good Morning";
      } else if (d.hour < 15) {
        curGreet = "Good Afternoon";
      } else if (d.hour < 21) {
        curGreet = "Good Evening";
      } else {
        curGreet = "Good Night";
      }
      curTime = "${d.hour}:${d.minute}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        curTime,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
