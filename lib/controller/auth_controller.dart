import 'package:ecommerce_seller_app/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  final RxBool isCheck = false.obs;
  var isloading = false.obs;
  //for signup screen
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordconfirmController = TextEditingController();
  var nameControllers = TextEditingController();

  //for login screen
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();

  void setCheck(bool value) {
    isCheck.value = value;
  }

  //login method
  Future<UserCredential?> loginMethod(
      {context, required String email, required String password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    if (userCredential != null) {
      return userCredential;
    } else {
      return null;
    }
  }

  // //signup method
  // Future<UserCredential?> signupMethod({context, email, password}) async {
  //   UserCredential? userCredential;
  //   try {
  //     userCredential = await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //   }
  //   return userCredential;
  // }

  // //storing data method
  // storeUserData({name, password, email}) async {
  //   DocumentReference store =
  //       firestore.collection(usersCollection).doc(currentUser!.uid);
  //   store.set({
  //     'name': name,
  //     'password': password,
  //     'email': email,
  //     'imageUrl': '',
  //     'id': currentUser!.uid,
  //     'cart_count': "00",
  //     'wishlist_count': "00",
  //     'order_count': "00"
  //   });
  // }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(
        context,
        msg: e.toString(),
      );
    }
  }
}
