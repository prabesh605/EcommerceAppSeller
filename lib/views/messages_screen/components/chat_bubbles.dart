import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget chatBubble() {
  return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.purpleAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            "Your Message ".text.make(),
            '10:45PM'.text.make(),
          ],
        ),
      ));
}
