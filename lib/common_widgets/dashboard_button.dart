import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget dashboardButton(context, {title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            "$title".text.bold.white.size(16).make(),
            "$count".text.bold.white.size(20).make(),
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 40,
        color: Colors.white,
      ),
    ],
  )
      .box
      .color(Colors.purple)
      .rounded
      .size(size.width * 0.4, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}
