import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/consts/firebase_consts.dart';
import 'package:ecommerce_seller_app/consts/images.dart';
import 'package:ecommerce_seller_app/consts/lists.dart';
import 'package:ecommerce_seller_app/controller/auth_controller.dart';
import 'package:ecommerce_seller_app/controller/profile_controller.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/authentication_screen/login_screen.dart';
import 'package:ecommerce_seller_app/views/messages_screen/messages_screen.dart';
import 'package:ecommerce_seller_app/views/profile_screen/edit_profilescreen.dart';
import 'package:ecommerce_seller_app/views/shop_setting/shop_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 109, 173, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 177, 243),
        automaticallyImplyLeading: false,
        title: "Settings".text.make(),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => EditProfileScreen(
                    username: controller.snapshotData['vendor_name'],
                  ));
            },
            icon: const Icon(Icons.edit),
          ),
          TextButton(
              onPressed: () async {
                await Get.find<AuthController>().signoutMethod(context);
                Get.offAll(() => const LoginScreen());
              },
              child: "Logout".text.semiBold.make()),
        ],
      ),
      body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              controller.snapshotData = snapshot.data!.docs[0];

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        controller.snapshotData['imageUrl'] == ""
                            ? ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                    imgModel5,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                    controller.snapshotData['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        16.widthBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.snapshotData['vendor_name']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            4.heightBox,
                            Text(
                              "${controller.snapshotData['email']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  10.heightBox,
                  Column(
                    children: List.generate(
                      profileButtonsIcons.length,
                      (index) => ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const ShopSetting());
                              break;
                            case 1:
                              Get.to(() => const MessageScreen());
                              break;
                            default:
                          }
                        },
                        leading: Icon(
                          profileButtonsIcons[index],
                          color: Colors.white,
                        ),
                        title: profileButtonsTitles[index].text.make(),
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
