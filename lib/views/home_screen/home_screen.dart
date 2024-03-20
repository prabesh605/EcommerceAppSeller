import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/common_widgets/dashboard_button.dart';
import 'package:ecommerce_seller_app/consts/firebase_consts.dart';
import 'package:ecommerce_seller_app/consts/images.dart';
import 'package:ecommerce_seller_app/controller/home_controller.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Dashboard".text.bold.size(18).make(),
        actions: [
          Center(
            child: intl.DateFormat("EEE, MMM d, ''yy")
                .format(DateTime.now())
                .text
                .color(Colors.purple)
                .make(),
          ),
          10.widthBox,
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context,
                    title: "Products",
                    count: controller.totalProducts == null
                        ? "0"
                        : "${controller.totalProducts}",
                    icon: icProducts),
                dashboardButton(context,
                    title: "Orders",
                    count: controller.totalOrders == null
                        ? "0"
                        : "${controller.totalOrders}",
                    icon: icOrders),
              ],
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context,
                    title: "Rating", count: "60", icon: icStar),
                dashboardButton(context,
                    title: "Total Sales",
                    count: controller.totalSales == null
                        ? "0"
                        : "${controller.totalSales}",
                    icon: icOrders),
              ],
            ),
            10.heightBox,
            const Divider(),
            10.heightBox,
            "Recent Products".text.color(Colors.black87).size(16).make(),
            20.heightBox,
            Column(
              children: [
                SingleChildScrollView(
                  child: StreamBuilder(
                      stream:
                          StoreServices.getPopularProducts(currentUser!.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text("No data is added yet!"),
                          );
                        } else {
                          var data = snapshot.data!.docs;

                          return ListView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                              data.length,
                              (index) => ListTile(
                                onTap: () {},
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
                                subtitle: "Rs.${data[index]['p_price']}"
                                    .text
                                    .color(Colors.red)
                                    .semiBold
                                    .make(),
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
