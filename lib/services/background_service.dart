import 'dart:async';

import 'package:flutter/material.dart';

import '../models/day_and_time.dart';

class BackGroundColorsService extends ChangeNotifier {
  late int currentTimeSlotIndex;
  late Duration tillNext;
  Timer? _timer;

  List<TimeOfDaySlot> bgColorMapping = [
    TimeOfDaySlot(
      start: TimeOfDay(hour: 4, minute: 0),
      end: TimeOfDay(hour: 6, minute: 0),
      bgColors: [Color(0XFF0D1B2A), Color(0XFF4B6E7D), Color(0XFFFFD700)],
      bgColorsStop: [0.0, 0.5, 1.0],
      grassColor: Color(0XFF2E8B57),
    ),
    TimeOfDaySlot(
      start: TimeOfDay(hour: 6, minute: 0),
      end: TimeOfDay(hour: 7, minute: 0),
      bgColors: [Color(0XFFFFA500), Color(0XFFFFE4B5), Color(0XFFB0E0E6)],
      bgColorsStop: [0.0, 0.4, 1.0],
      grassColor: Color(0XFF32CD32),
    ),
    TimeOfDaySlot(
      start: TimeOfDay(hour: 7, minute: 0),
      end: TimeOfDay(hour: 10, minute: 0),
      bgColors: [Color(0XFF87CEFA), Color(0XFF00CED1), Color(0XFFB0E0E6)],
      bgColorsStop: [0.0, 0.4, 1.0],
      grassColor: Color(0XFF228B22),
    ),
    TimeOfDaySlot(
      start: TimeOfDay(hour: 10, minute: 0),
      end: TimeOfDay(hour: 12, minute: 0),
      bgColors: [Color(0XFF00BFFF), Color(0XFFB0E0E6), Color(0XFFAFEEEE)],
      bgColorsStop: [0.0, 0.35, 1.0],
      grassColor: Color(0XFF7CFC00),
    ),
    TimeOfDaySlot(
      start: TimeOfDay(hour: 12, minute: 0),
      end: TimeOfDay(hour: 15, minute: 0),
      bgColors: [Color(0XFF4682B4), Color(0XFF87CEFA), Color(0XFFB0E0E6)],
      bgColorsStop: [0.0, 0.35, 1.0],
      grassColor: Color(0XFF98FB98),
    ),
    TimeOfDaySlot(
      start: TimeOfDay(hour: 15, minute: 0),
      end: TimeOfDay(hour: 17, minute: 0),
      bgColors: [Color(0XFFFF6347), Color(0XFFFFA500), Color(0XFFFFD700)],
      bgColorsStop: [0.0, 0.3, 1.0],
      grassColor: Color(0XFF556B2F),
    ),
    TimeOfDaySlot(
      start: TimeOfDay(hour: 17, minute: 0),
      end: TimeOfDay(hour: 19, minute: 0),
      bgColors: [Color(0XFFFF4500), Color(0XFFFF6347), Color(0XFF8A2BE2)],
      bgColorsStop: [0.0, 0.35, 1.0],
      grassColor: Color(0XFF4B0082),
    ),
    TimeOfDaySlot(
      start: TimeOfDay(hour: 19, minute: 0),
      end: TimeOfDay(hour: 20, minute: 0),
      bgColors: [Color(0XFF6A5ACD), Color(0XFF8A2BE2), Color(0XFFBA55D3)],
      bgColorsStop: [0.0, 0.4, 1.0],
      grassColor: Color(0XFF2F4F4F),
    ),
    TimeOfDaySlot(
      start: TimeOfDay(hour: 20, minute: 0),
      end: TimeOfDay(hour: 4, minute: 0),
      bgColors: [Color(0XFF191970), Color(0XFF000000), Color(0XFF6A5ACD)],
      bgColorsStop: [0.0, 0.4, 1.0],
      grassColor: Color(0XFF556B2F),
    ),
  ];

  BackGroundColorsService() {
    _setCurrentTimeSlot();
  }

  void _setCurrentTimeSlot() {
    final currentHour = DateTime.now().hour;
    currentTimeSlotIndex = bgColorMapping.indexWhere((slot) {
      if (slot.start.hour <= slot.end.hour) {
        return currentHour >= slot.start.hour && currentHour < slot.end.hour;
      } else {
        return currentHour >= slot.start.hour || currentHour < slot.end.hour;
      }
    });
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    final currentSlot = bgColorMapping[currentTimeSlotIndex];
    final now = DateTime.now();

    DateTime end = DateTime(
      now.year,
      now.month,
      now.day,
      currentSlot.end.hour,
      currentSlot.end.minute,
    );

    if (currentSlot.start.hour > currentSlot.end.hour) {
      end = end.add(Duration(days: 1));
    }

    tillNext = end.difference(now);
    _timer = Timer(tillNext, () {
      _setCurrentTimeSlot();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
