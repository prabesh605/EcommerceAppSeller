import 'package:ecommerce_seller_app/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: "$hint".text.make(),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            child: e.toString().text.make(),
            value: e,
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Category") {
            controller.subcategoryvalue.value = '';
            controller.populateSubCategory(newValue.toString());
          }
          dropvalue.value = newValue.toString();
        },
      ),
    )
        .box
        .white
        .padding(
          const EdgeInsets.symmetric(horizontal: 4),
        )
        .roundedSM
        .make(),
  );
}
