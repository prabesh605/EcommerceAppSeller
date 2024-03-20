import 'package:ecommerce_seller_app/common_widgets/custom_textfield.dart';
import 'package:ecommerce_seller_app/common_widgets/our_button.dart';
import 'package:ecommerce_seller_app/consts/images.dart';
import 'package:ecommerce_seller_app/controller/auth_controller.dart';
import 'package:ecommerce_seller_app/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 160, 99, 197),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 160, 99, 197),
          automaticallyImplyLeading: false,
          title: "Seller Login".text.make(),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Image.asset(
                  iclogo,
                  height: 200,
                ),
                "Seller".text.bold.size(20).make(),
                customTextField(
                    name: "Email",
                    hint: "Enter your email",
                    controller: controller.loginEmailController),
                5.heightBox,
                customTextField(
                    name: "Password",
                    hint: "Enter your password",
                    ispass: true,
                    controller: controller.loginPasswordController),
                10.heightBox,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: "Forgot password".text.make(),
                  ),
                ),
                controller.isloading.value
                    ? const CircularProgressIndicator()
                    : ourButton(
                        text: "Login",
                        onPressed: () async {
                          // Get.to(() => const Home());
                          controller.isloading.value = true;
                          await controller
                              .loginMethod(
                                  context: context,
                                  email: controller.loginEmailController.text,
                                  password:
                                      controller.loginPasswordController.text)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: "Logged in ");
                              Get.offAll(() => const Home());
                              controller.isloading.value = false;
                            }
                          });
                        }).box.width(context.screenWidth - 50).make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
