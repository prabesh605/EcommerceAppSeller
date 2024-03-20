import 'package:ecommerce_seller_app/common_widgets/our_button.dart';
import 'package:ecommerce_seller_app/controller/orders_controller.dart';
import 'package:ecommerce_seller_app/views/orders_screen/components/order_place.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, this.data});
  final dynamic data;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.put(OrdersController());
  @override
  void initState() {
    super.initState();
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Order Details".text.bold.size(16).make(),
      ),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 50,
            width: context.screenWidth,
            child: ourButton(
              color: Colors.green,
              onPressed: () {
                controller.confirmed(true);
                controller.changeStatus(
                  title: "order_confirmed",
                  status: true,
                  docID: widget.data.id,
                );
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    controller.ondelivery(true);
                    controller.changeStatus(
                      title: "order_on_delivery",
                      status: true,
                      docID: widget.data.id,
                    );
                  });
                });
              },
              text: "Confirm Order",
            ),
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: "Order Status"
                            .text
                            .bold
                            .color(Colors.black87)
                            .size(16)
                            .make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.green,
                        value: true,
                        onChanged: (value) {},
                        title: "Placed".text.bold.color(Colors.black54).make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          // controller.confirmed(value);
                          // controller.changeStatus(
                          //   title: "order_confirmed",
                          //   status: value,
                          //   docID: widget.data.id,
                          // );
                        },
                        title:
                            "Confirmed".text.bold.color(Colors.black54).make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.green,
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          // controller.ondelivery(value);
                          // controller.changeStatus(
                          //   title: "order_on_delivery",
                          //   status: value,
                          //   docID: widget.data.id,
                          // );
                        },
                        title: "On Delivery"
                            .text
                            .bold
                            .color(Colors.black54)
                            .make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.green,
                        value: controller.delivered.value,
                        onChanged: (value) {},
                        title:
                            "Delievered".text.bold.color(Colors.black54).make(),
                      ),
                    ],
                  )
                      .box
                      .outerShadowMd
                      .white
                      .border(color: Colors.black45)
                      .roundedSM
                      .make(),
                ),
                5.heightBox,
                Column(
                  children: [
                    orderPlaceDetails(
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['shipping_method']}",
                      title1: "Order code",
                      title2: "Shipping method",
                    ),
                    orderPlaceDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format(widget.data['order_date'].toDate()),
                      d2: "${widget.data['Payment_method']}",
                      title1: "Order date",
                      title2: "Payment method",
                    ),
                    orderPlaceDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address"
                                  .text
                                  .bold
                                  .color(Colors.purple)
                                  .make(),
                              "${widget.data["order_by_name"]}".text.make(),
                              "${widget.data["order_by_email"]}".text.make(),
                              "${widget.data["order_by_address"]}".text.make(),
                              "${widget.data["order_by_city"]}".text.make(),
                              "${widget.data["order_by_state"]}".text.make(),
                              "${widget.data["order_by_phone"]}".text.make(),
                              "${widget.data["order_by_postalcode"]}"
                                  .text
                                  .make(),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount"
                                    .text
                                    .bold
                                    .color(Colors.purple)
                                    .make(),
                                "Rs. ${widget.data['total_amount']}"
                                    .text
                                    .bold
                                    .color(Colors.red)
                                    .make(),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .roundedSM
                    .border(color: Colors.black26)
                    .make(),
                const Divider(),
                10.heightBox,
                "Order Products"
                    .text
                    .bold
                    .color(Colors.black54)
                    .size(16)
                    .make(),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children:
                      List.generate(widget.data['orders'].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          d1: " ${widget.data['orders'][index]['title']}",
                          d2: "Rs. ${widget.data['orders'][index]['tprice']}",
                          title1: "x${widget.data['orders'][index]['qty']}",
                          title2: "Refundable",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(widget.data['orders'][index]['color']),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
