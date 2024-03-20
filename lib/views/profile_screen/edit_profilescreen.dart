import 'dart:io';

import 'package:ecommerce_seller_app/common_widgets/custom_textfield.dart';
import 'package:ecommerce_seller_app/consts/images.dart';
import 'package:ecommerce_seller_app/controller/profile_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

//TODO: profile update is not solved yet

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.username});
  final String? username;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Settings".text.size(16).make(),
          actions: [
            TextButton(
              onPressed: () async {
                //if image is not selected
                if (controller.profileImgPath.value.isNotEmpty) {
                  await controller.uploadProfileImage();
                } else {
                  controller.profileImageLink =
                      controller.snapshotData['imageUrl'];
                }
                //if old password matches database
                if (controller.snapshotData['password'] ==
                    controller.oldPassword.text) {
                  await controller.changeAuthPassword(
                      email: controller.snapshotData['email'],
                      oldPassword: controller.oldPassword.text,
                      newPassword: controller.newPassword.text);
                  await controller.updateProfile(
                      imgUrl: controller.profileImageLink,
                      name: controller.nameController.text,
                      password: controller.newPassword.text);
                  VxToast.show(context, msg: "Updated");
                } else if (controller.oldPassword.text.isEmptyOrNull &&
                    controller.newPassword.text.isEmptyOrNull) {
                  await controller.updateProfile(
                      imgUrl: controller.profileImageLink,
                      name: controller.nameController.text,
                      password: controller.snapshotData['password']);
                  VxToast.show(context, msg: "Updated");
                } else {
                  VxToast.show(context, msg: "Some error occured");
                }
              },
              child: "Save ".text.bold.make(),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              //if data image url and controller path is empty
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgModel5,
                      width: 150,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :
                  //if data is not empty but controller path is empty
                  controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      //else if controller path is not empty but data image url is
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: "Change Image ".text.bold.make(),
              ),
              10.heightBox,
              const Divider(
                color: Colors.white,
              ),
              10.heightBox,
              customTextField(
                controller: controller.nameController,
                name: "Username",
                hint: "eg. Hari Prasad",
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: "Change your password ".text.bold.make(),
                  )),
              customTextField(
                ispass: true,
                controller: controller.oldPassword,
                name: "Password",
                hint: "*****",
              ),
              10.heightBox,
              customTextField(
                ispass: true,
                controller: controller.newPassword,
                name: "New Password",
                hint: "*****",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
