import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/view/world_status.dart';
import 'dart:math' as math;

import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  //Changing Screen
  changeScreen() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Get.offAll(()=> WorldStatusScreen());
    });
  }

@override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                child: Container(
                  height: Get.height * 0.4,
                  width: Get.width * 0.7,
                  child: Image(image: AssetImage("assets/images/virus.png")),
                ),
                animation: controller,
                builder: (context, Widget? child) {
                  return Transform.rotate(
                    angle: controller.value * 2.5 * math.pi,
                    child: child,
                  );
                }).box.makeCentered(),
            "Covid-19\nTracker App"
                .text
                .size(30).align(TextAlign.center)
                .fontWeight(FontWeight.bold)
                .make(),
          ],
        ),
      ),
    );
  }
}
