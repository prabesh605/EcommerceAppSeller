import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.bold.color(Colors.purple).make(),
            "$d1".text.bold.color(Colors.red).make(),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.bold.color(Colors.purple).make(),
              "$d2".text.semiBold.color(Colors.black87).make(),
            ],
          ),
        )
      ],
    ),
  );
}
