import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_launcher/services/background_service.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final ScrollController customDrawerController = ScrollController();
  List<Color> bgColor = [
    Color(0XFF2C3E50),
    Color(0XFF2C3E50),
    Color(0XFF2C3E50),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<BackGroundColorsService>(
            builder: (context, bgService, child) {
              return Center(
                child: AnimatedContainer(
                  duration: bgService.tillNext,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:
                          bgService
                              .bgColorMapping[bgService.currentTimeSlotIndex]
                              .bgColors,
                      stops:
                          bgService
                              .bgColorMapping[bgService.currentTimeSlotIndex]
                              .bgColorsStop,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
