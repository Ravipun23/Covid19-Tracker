import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/Models/Services/state_services.dart';
import 'package:new_project/Models/world_status_model.dart';
import 'package:new_project/resuable_widget/my_button.dart';
import 'package:new_project/view/countries_status.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math' as math;

import '../resuable_widget/resuable_row.dart';

class WorldStatusScreen extends StatefulWidget {
  const WorldStatusScreen({super.key});

  @override
  State<WorldStatusScreen> createState() => _WorldStatusScreenState();
}

class _WorldStatusScreenState extends State<WorldStatusScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final double screenHeight = Get.height * 0.05;
  final double screenWidth = Get.width;

  final colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              20.widthBox,
              "C"
                  .text
                  .fontWeight(FontWeight.bold)
                  .size(30)
                  .color(Color.fromARGB(255, 21, 164, 177))
                  .make(),
                  
              AnimatedBuilder(
                  child: Container(
                    height: 25,
                    width: 25,
                    child: Image(image: AssetImage("assets/images/virus.png")),
                  ),
                  animation: controller,
                  builder: (context, Widget? child) {
                    return Transform.rotate(
                      angle: controller.value * 2.5 * math.pi,
                      child: child,
                    );
                  },
                ),
              "vid-19"
                  .text
                  .fontWeight(FontWeight.bold)
                  .size(30)
                  .color(Color.fromARGB(255, 21, 164, 177))
                  .make(),
            ],
          ),
          20.heightBox,
          FutureBuilder(
              future: stateServices.fetchWorldStatusData(),
              builder: (context, AsyncSnapshot<WorldStatusModel> snapshot) {
                if (!snapshot.hasData) {
                  return Builder(builder: (context) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Vx.white,
                        controller: controller,
                        size: 50,
                      ),
                    );
                  });
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recoverd": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: screenWidth / 3.2,
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        20.heightBox,
                        Column(
                          children: [
                            "World Status:"
                                .text
                                .fontWeight(FontWeight.bold)
                                .size(22)
                                .color(Vx.amber100)
                                .make(),
                            resuableRow(
                                title: "Total Cases",
                                value: snapshot.data!.cases.toString()),
                            resuableRow(
                                title: "Total Death",
                                value: snapshot.data!.deaths.toString()),
                            resuableRow(
                                title: "Total Recovered",
                                value: snapshot.data!.recovered.toString()),
                            resuableRow(
                                title: "Active",
                                value: snapshot.data!.active.toString()),
                            resuableRow(
                                title: "Critical",
                                value: snapshot.data!.critical.toString()),
                            resuableRow(
                                title: "Today Death",
                                value: snapshot.data!.todayDeaths.toString()),
                            resuableRow(
                                title: "Today Recovered",
                                value:
                                    snapshot.data!.todayRecovered.toString()),
                          ],
                        )
                            .box
                            .outerShadow
                            .rounded
                            .padding(EdgeInsets.all(8))
                            .margin(EdgeInsets.symmetric(horizontal: 5))
                            .make(),
                        myButton(
                            title: "Track Countries",
                            onpress: () {
                              Get.to(() => CountriesStatusScreen());
                            },
                            width: Get.width * 0.9),
                      ],
                    ),
                  );
                }
              }),
        ],
      )),
    );
  }
}
