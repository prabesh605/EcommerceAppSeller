import 'package:ecommerce_seller_app/common_widgets/custom_textfield.dart';
import 'package:ecommerce_seller_app/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopSetting extends StatelessWidget {
  const ShopSetting({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        title: "Shop Setting".text.bold.size(16).make(),
        actions: [
          controller.isloading.value == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TextButton(
                  onPressed: () {
                    controller.updateShop(
                      shopaddress: controller.shopAddressController.text,
                      shopname: controller.shopNameController.text,
                      shopdesc: controller.shopDesController.text,
                      shopmobile: controller.shopMobileController.text,
                      shopwebsite: controller.shopWebsiteController.text,
                    );
                  },
                  child: "Save".text.semiBold.make())
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            customTextField(
              controller: controller.shopNameController,
              name: "Shop Name",
              hint: "Hari Prasad",
            ),
            10.heightBox,
            customTextField(
              controller: controller.shopAddressController,
              name: "Address",
              hint: "Kathmandu",
            ),
            10.heightBox,
            customTextField(
              controller: controller.shopMobileController,
              name: "Mobile",
              hint: "Shop mobile",
            ),
            10.heightBox,
            customTextField(
              controller: controller.shopWebsiteController,
              name: "Website",
              hint: "www.mobileshop.com",
            ),
            10.heightBox,
            customTextField(
              controller: controller.shopDesController,
              isDesc: true,
              name: "Description",
              hint: "Enter Description",
            ),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
