import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField(
    {String? name,
    String? hint,
    isDesc = false,
    ispass = false,
    controller,
    String? errorText}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "$name".text.color(Colors.red).size(18).make(),
        5.heightBox,
        TextFormField(
          maxLines: isDesc ? 4 : 1,
          controller: controller,
          style: const TextStyle(fontSize: 18),
          obscureText: ispass,
          onChanged: (_) {},
          decoration: InputDecoration(
            hintText: "$hint",
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            errorText: null,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10), // Set border radius
            ),
          ),
        ).box.shadowSm.make(),
        if (errorText != null)
          Text(
            errorText,
            style: const TextStyle(color: Colors.red),
          ),
      ],
    ),
  );
}
