import 'package:ecommerce_seller_app/common_widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.bold.size(18).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exist?".text.size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: Colors.red,
                onPressed: () {
                  SystemNavigator.pop();
                },
                text: "Yes"),
            ourButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "No"),
          ],
        )
      ],
    ).box.padding(const EdgeInsets.all(12)).rounded.make(),
  );
}
