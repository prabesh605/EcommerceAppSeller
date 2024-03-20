import 'package:ecommerce_seller_app/consts/images.dart';
import 'package:ecommerce_seller_app/controller/home_controller.dart';
import 'package:ecommerce_seller_app/views/home_screen/home_screen.dart';
import 'package:ecommerce_seller_app/views/orders_screen/orders_screen.dart';
import 'package:ecommerce_seller_app/views/products_screen/products_screen.dart';
import 'package:ecommerce_seller_app/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var bottomNavbar = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 24,
          ),
          label: "Dashboard"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
          ),
          label: "Products"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 24,
          ),
          label: "Orders"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icSetting,
            width: 24,
          ),
          label: "Settings"),
    ];
    var navScreens = [
      const HomeScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          items: bottomNavbar,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
        ),
        body: Column(
          children: [
            Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
            ),
          ],
        ),
      ),
    );
  }
}
