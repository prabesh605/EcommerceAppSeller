import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .size(16)
      .makeCentered()
      .box
      .white
      .size(100, 100)
      .roundedSM
      .make();
}
