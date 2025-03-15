import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

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
    Timer.periodic(const Duration(milliseconds: 1), (timer) => updateTime());
    super.initState();
  }

  void updateTime() {
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
              style: const TextStyle(fontSize: 20, color: Colors.white38),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            width: 145,
            height: 145,
            child: CustomPaint(
              painter: ClockPainter(
                hour: DateTime.now().hour % 12,
                minute: DateTime.now().minute,
                second: second,
                millisecond: millisecond,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ClockPainter extends CustomPainter {
  const ClockPainter({
    required this.hour,
    required this.minute,
    required this.second,
    required this.millisecond,
  });
  final int hour;
  final int minute;
  final int second;
  final int millisecond;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintHour =
        Paint()
          ..color = const Color(0xff010101)
          ..style = PaintingStyle.fill;
    Paint paintHourShadow =
        Paint()
          ..color = const Color(0xff021f1c)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);
    Paint paintMinute =
        Paint()
          ..color = const Color(0xff021f1c)
          ..style = PaintingStyle.fill;
    Paint paintMinuteShadow =
        Paint()
          ..color = const Color(0xff021f1c)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);
    Paint paintSecond =
        Paint()
          ..color = const Color(0xff0d6767)
          ..style = PaintingStyle.fill;
    Paint paintSecondShadow =
        Paint()
          ..color = const Color(0xff021f1c)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);
    canvas.drawArc(
      const Offset(0, 0) & Size(size.width, size.height),
      3 * pi / 2,
      (hour * pi / 6) + (minute * pi / 360),
      true,
      paintHour,
    );
    canvas.drawArc(
      const Offset(0, 0) & Size(size.width, size.height),
      3 * pi / 2,
      (hour * pi / 6) + (minute * pi / 360),
      true,
      paintHourShadow,
    );
    canvas.drawArc(
      const Offset(20, 20) & Size(size.width - 40, size.height - 40),
      3 * pi / 2,
      (minute * pi / 30) + ((second * 0.1) * pi / 180),
      true,
      paintMinute,
    );
    canvas.drawArc(
      const Offset(20, 20) & Size(size.width - 40, size.height - 40),
      3 * pi / 2,
      (minute * pi / 30) + ((second * 0.1) * pi / 180),
      true,
      paintMinuteShadow,
    );
    canvas.drawArc(
      const Offset(40, 40) & Size(size.width - 80, size.height - 80),
      3 * pi / 2,
      (second * pi / 30) + ((millisecond * 6 / 1000) * pi / 180),
      true,
      paintSecond,
    );
    canvas.drawArc(
      const Offset(40, 40) & Size(size.width - 80, size.height - 80),
      3 * pi / 2,
      (second * pi / 30) + ((millisecond * 6 / 1000) * pi / 180),
      true,
      paintSecondShadow,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
