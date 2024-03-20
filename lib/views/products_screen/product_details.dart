import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 213, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 203, 238),
        title: "${data['p_subcategory']}".text.bold.size(16).make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                itemCount: 3,
                height: 260,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.network(
                    data['p_imgs'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['p_subcategory']}".text.size(16).make(),
                          "${data['p_name']}".text.bold.size(16).make(),
                        ],
                      ),
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        maxRating: 5,
                        onRatingUpdate: (value) {},
                        normalColor: Colors.black26,
                        selectionColor: Colors.orange,
                        count: 5,
                        size: 25,
                        stepInt: true,
                      ),
                    ],
                  ),

                  10.heightBox,

                  //rating

                  10.heightBox,
                  "Rs. ${data['p_price']}"
                      .text
                      .bold
                      .color(Colors.red)
                      .size(18)
                      .make(),
                  20.heightBox,
                  Column(
                    children: [
                      5.heightBox,
                      Row(
                        children: [
                          1.heightBox,
                          SizedBox(
                            width: 100,
                            child: " Color".text.bold.size(16).make(),
                          ),
                          Row(
                            children: List.generate(
                              3,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Color(data['p_colors'][index]))
                                  .margin(
                                    const EdgeInsets.symmetric(horizontal: 4),
                                  )
                                  .make()
                                  .onTap(() {}),
                            ),
                          ),
                        ],
                      ),

                      //quantity row
                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: " Quantity".text.bold.size(16).make(),
                          ),
                          "${data['p_quantity']} items".text.size(16).make(),
                        ],
                      ),
                      5.heightBox,
                    ],
                  ).box.white.roundedSM.shadowSm.make(),
                  const Divider(),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        5.heightBox,
                        " Description".text.bold.size(16).make(),
                        10.heightBox,
                        " ${data['p_desc']}".text.size(16).make(),
                        10.heightBox,
                      ],
                    ),
                  ).box.roundedSM.shadowSm.white.make()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
