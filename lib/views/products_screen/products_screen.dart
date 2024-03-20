import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/consts/firebase_consts.dart';
import 'package:ecommerce_seller_app/consts/lists.dart';
import 'package:ecommerce_seller_app/controller/products_controller.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/products_screen/add_products.dart';
import 'package:ecommerce_seller_app/views/products_screen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var controller = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "My Products".text.make(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () async {
            await controller.getCategories();
            await controller.populateCategoryList();
            Get.to(() => const AddProducts());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            StreamBuilder(
                stream: StoreServices.getProducts(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var data = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: List.generate(
                            data.length,
                            (index) => ListTile(
                              onTap: () {
                                Get.to(() => ProductDetails(
                                      data: data[index],
                                    ));
                              },
                              leading: Image.network(
                                data[index]['p_imgs'][0],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              title: "${data[index]['p_name']}"
                                  .text
                                  .color(Colors.black87)
                                  .bold
                                  .make(),
                              subtitle: Row(
                                children: [
                                  "Rs. ${data[index]['p_price']}"
                                      .text
                                      .color(Colors.red)
                                      .semiBold
                                      .make(),
                                  10.widthBox,
                                  data[index]['is_featured']
                                      ? "Featured"
                                          .text
                                          .color(Colors.green)
                                          .semiBold
                                          .make()
                                      : "".text.make(),
                                ],
                              ),
                              trailing: VxPopupMenu(
                                arrowSize: 0.0,
                                menuBuilder: () => Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: List.generate(
                                      popupMenuTitles.length,
                                      (index) => Row(
                                        children: [
                                          Icon(popupMenuIcons[index]),
                                          10.widthBox,
                                          popupMenuTitles[index].text.make()
                                        ],
                                      ).onTap(() {
                                        switch (index) {
                                          case 0:
                                            if (data[index]['is_featured'] ==
                                                true) {
                                              controller.removeFeatured(
                                                  data[index].id);
                                              VxToast.show(context,
                                                  msg: "Freatured Removed");
                                            } else {
                                              controller
                                                  .addFeatured(data[index].id);
                                              VxToast.show(context,
                                                  msg: "Freatured added");
                                            }
                                            break;
                                          case 1:
                                            break;
                                          case 2:
                                            controller
                                                .removeProduct(data[index].id);
                                            break;
                                        }
                                      }),
                                    ),
                                  ),
                                ).box.white.rounded.width(200).make(),
                                clickType: VxClickType.singleClick,
                                child: const Icon(Icons.more_vert_rounded),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ],
        ));
  }
}
