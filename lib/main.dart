import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_apps/app_info.dart';
import 'package:get_apps/get_apps.dart';

void main() => runApp(const App());

List<String> monthName = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
List<String> dayName = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xff014b4c),
        )
      ),
      home:const HomeDrawer(),
    );
  }
}

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late Future<List<AppInfo>> _allUserApps;
  @override
  void initState() {
    _allUserApps = GetApps().getUserApps();
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

class AppClickableIcon extends StatelessWidget {
  final AppInfo appInfo;
  const AppClickableIcon({Key? key, required this.appInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>GetApps().runExternalApp(appInfo.appPackage),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Center(
        child: Image.memory(
          appInfo.appIcon,height : 80, width : 80,
        ),
      ),
    );
  }
}


class CustomClock extends StatefulWidget {
  const CustomClock({Key? key}) : super(key: key);

  @override
  State<CustomClock> createState() => _CustomClockState();
}

class _CustomClockState extends State<CustomClock> {
  late int hour;
  late int minute;
  late int second;
  late int millisecond;
  late DateTime curTime;
  @override
  void initState() {
    curTime = DateTime.now();
    hour = curTime.hour % 12;
    minute = curTime.minute;
    second = curTime.second;
    millisecond = curTime.millisecond;
    Timer.periodic(const Duration(milliseconds: 1), (timer) =>updateTime());
    super.initState();
  }
  void updateTime(){
    setState(() {
      curTime = DateTime.now();
      hour = curTime.hour % 12;
      minute = curTime.minute;
      second = curTime.second;
      millisecond = curTime.millisecond;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              "${hour == 0 ? 12 : hour} : $minute\n ${monthName[curTime.month]} ${curTime.day}",
              style: const TextStyle(
                color: Colors.white70,
                height: 1,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            subtitle: Text(
              dayName[curTime.weekday % 7],
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white38,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        SizedBox(
          width: 145,
          height: 145,
          child: CustomPaint(
            painter: ClockPainter(hour: DateTime.now().hour % 12, minute: DateTime.now().minute, second: second, millisecond: millisecond),
            child: const Center(
              child: Text(""),
            ),
          ),
        ),
      ],
    );
  }
}


class ClockPainter extends CustomPainter{
  const ClockPainter({required this.hour, required this.minute, required this.second, required this.millisecond});
  final int hour;
  final int minute;
  final int second;
  final int millisecond;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintHour = Paint()..color = const Color(0xff010101)..style = PaintingStyle.fill;
    Paint paintHourShadow = Paint()..color = const Color(0xff021f1c)..style = PaintingStyle.fill..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);
    Paint paintMinute = Paint()..color = const Color(0xff021f1c)..style = PaintingStyle.fill;
    Paint paintMinuteShadow = Paint()..color = const Color(0xff021f1c)..style = PaintingStyle.fill..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);
    Paint paintSecond = Paint()..color = const Color(0xff0d6767)..style = PaintingStyle.fill;
    Paint paintSecondShadow = Paint()..color = const Color(0xff021f1c)..style = PaintingStyle.fill..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);
    canvas.drawArc(const Offset(0, 0) & Size(size.width, size.height), 3 * pi / 2, (hour * pi / 6) + (minute * pi / 360), true, paintHour);
    canvas.drawArc(const Offset(0, 0) & Size(size.width, size.height), 3 * pi / 2, (hour * pi / 6) + (minute * pi / 360), true, paintHourShadow);
    canvas.drawArc(const Offset(20, 20) & Size(size.width - 40, size.height - 40), 3 * pi / 2, (minute * pi / 30) + ((second * 0.1) * pi / 180), true, paintMinute);
    canvas.drawArc(const Offset(20, 20) & Size(size.width - 40, size.height - 40), 3 * pi / 2, (minute * pi / 30) + ((second * 0.1) * pi / 180), true, paintMinuteShadow);
    canvas.drawArc(const Offset(40, 40) & Size(size.width - 80, size.height - 80), 3 * pi / 2, (second * pi / 30) + ((millisecond * 6 / 1000) * pi / 180), true, paintSecond);
    canvas.drawArc(const Offset(40, 40) & Size(size.width - 80, size.height - 80), 3 * pi / 2, (second * pi / 30) + ((millisecond * 6 / 1000) * pi / 180), true, paintSecondShadow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
