
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/resuable_widget/resuable_row.dart';
import 'package:velocity_x/velocity_x.dart';

class CountriesDetails extends StatefulWidget {
  final String title;
  final String totalCases;
  final String totalRecovered;
  final String totalDeath;
  final String critical;
  final String flag;
  final String active;
  const CountriesDetails({
    Key? key,
    required this.title,
    required this.totalCases,
    required this.totalRecovered,
    required this.totalDeath,
    required this.critical,
    required this.active,
    required this.flag,
  }) : super(key: key);

  @override
  State<CountriesDetails> createState() => _CountriesDetailsState();
}

class _CountriesDetailsState extends State<CountriesDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: widget.title.text.make(),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    left: 10,
                    right: 10),
                child: Card(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      resuableRow(
                        title: "Total Cases",
                        value: widget.totalCases,
                      ),
                      resuableRow(
                          title: "Total Death", value: widget.totalDeath),
                      resuableRow(
                          title: "Total Recovered",
                          value: widget.totalRecovered),
                      resuableRow(title: "Active", value: widget.active),
                      resuableRow(title: "Critical", value: widget.critical),
                    ],
                  ),
                ),
              ),
              (widget.title == "Nepal")
                  ? CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 67, 71, 71),
                      radius: 50,
                      child: Image(
                        image: NetworkImage(
                          widget.flag,
                        ),
                        height: 80,
                        width: 60,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: NetworkImage(widget.flag),
                    )
            ],
          )
        ],
      ),
    ));
  }
}
