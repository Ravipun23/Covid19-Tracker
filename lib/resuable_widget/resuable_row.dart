import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget resuableRow({String? title, String? value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      title!.text.fontWeight(FontWeight.bold).size(16).make(),
      value!.text.fontWeight(FontWeight.bold).size(16).make(),
    ],
  ).box.padding(EdgeInsets.all(20)).make();
}
