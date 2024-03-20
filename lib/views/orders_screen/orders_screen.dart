import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/consts/firebase_consts.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/orders_screen/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Orders".text.make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder(
            stream: StoreServices.getOrders(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Column(
                  children: List.generate(data.length, (index) {
                    var t = data[index]['order_date'].toDate();
                    return ListTile(
                      onTap: () {
                        Get.to(
                          () => OrderDetails(
                            data: data[index],
                          ),
                        );
                      },
                      tileColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: "${data[index]['order_code']}"
                          .text
                          .bold
                          .color(Colors.purple)
                          .bold
                          .make(),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month),
                              10.widthBox,
                              intl.DateFormat()
                                  .add_yMd()
                                  .format(DateTime.now())
                                  .text
                                  .color(Colors.red)
                                  .semiBold
                                  .make(),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: Colors.grey,
                              ),
                              "Unpaid".text.color(Colors.red).bold.make(),
                            ],
                          )
                        ],
                      ),
                      trailing: "Rs. ${data[index]['total_amount']}"
                          .text
                          .color(Colors.red)
                          .size(16)
                          .semiBold
                          .make(),
                    ).box.margin(const EdgeInsets.only(bottom: 8)).make();
                  }),
                );
              }
            }),
      ),
    );
  }
}
