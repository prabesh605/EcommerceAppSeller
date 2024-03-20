import 'package:ecommerce_seller_app/common_widgets/custom_textfield.dart';
import 'package:ecommerce_seller_app/consts/lists.dart';
import 'package:ecommerce_seller_app/controller/products_controller.dart';
import 'package:ecommerce_seller_app/views/products_screen/components/product_dropdown.dart';
import 'package:ecommerce_seller_app/views/products_screen/components/product_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  var controller = Get.find<ProductsController>();
  List<int> selectedColors = [];
  @override
  void initState() {
    super.initState();
    controller.pnameController.clear();
    controller.pdescController.clear();
    controller.ppriceController.clear();
    controller.pquantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 127, 176, 217),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 109, 165, 210),
        title: "Add Products".text.bold.make(),
        actions: [
          TextButton(
            onPressed: () async {
              await controller.uploadImages();
              await controller.uploadProduct(context, selectedColors);
              Get.back();
            },
            child: "Save".text.bold.make(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => Column(
              children: [
                customTextField(
                  controller: controller.pnameController,
                  hint: "Eg. Louis Shirt",
                  name: "Product name",
                ),
                customTextField(
                  controller: controller.pdescController,
                  hint: "Eg. Great Products with 1 year warrenty",
                  name: "Description",
                  isDesc: true,
                ),
                customTextField(
                  controller: controller.ppriceController,
                  hint: "Eg. Rs.3000",
                  name: "Price",
                ),
                customTextField(
                  controller: controller.pquantityController,
                  hint: "Eg. 20",
                  name: "Quantity",
                ),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropdown(
                  "Subcategory",
                  controller.subcategoryList,
                  controller.subcategoryvalue,
                  controller,
                ),
                10.heightBox,
                const Divider(),
                "Choose product images".text.bold.make(),
                10.heightBox,
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? Image.file(
                                controller.pImagesList[index],
                                width: 100,
                              )
                            : productImages(label: "${index + 1}")
                                .onTap(() async {
                                await controller.pickImage(index, context);
                              }),
                      ),
                    ),
                  ),
                ),
                5.heightBox,
                "First image will be your display image".text.make(),
                const Divider(),
                10.heightBox,
                "Choose products color".text.make(),
                10.heightBox,
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(
                    colorList.length,
                    (index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox()
                            .color(colorList[index])
                            .size(50, 50)
                            .roundedFull
                            .make()
                            .onTap(() {
                          controller.selectedColorIndex.value = index;
                          selectedColors.add(colorList[index].value);
                        }),
                        controller.selectedColorIndex.value == index
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
