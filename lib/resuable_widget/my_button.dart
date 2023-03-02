import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget myButton({String? title, width,onpress}){
  return ElevatedButton(
    style: TextButton.styleFrom(
      backgroundColor: Color(0xff1aa260),
      padding: EdgeInsets.all(16)
    ),
    onPressed: onpress, 
    child: title!.text.make()).box.rounded.shadowSm.width(width).make();
}