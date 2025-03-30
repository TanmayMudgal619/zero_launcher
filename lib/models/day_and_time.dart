import 'package:flutter/material.dart';

class TimeOfDaySlot {
  late TimeOfDay start, end;
  late List<Color> bgColors;
  late List<double> bgColorsStop;
  late Color grassColor;
  TimeOfDaySlot({
    required this.start,
    required this.end,
    required this.bgColors,
    required this.bgColorsStop,
    required this.grassColor,
  });

  bool inBetween(TimeOfDay timeOfDay) {
    return timeOfDay.isAfter(start) && timeOfDay.isBefore(end);
  }

  int duration() {
    return (start.hour - end.hour).abs();
  }
}
