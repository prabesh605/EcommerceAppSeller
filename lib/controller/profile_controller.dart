import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    //seller doc id will be get as this controller is invoked
    getVendorDocumentId();
  }

  late QueryDocumentSnapshot snapshotData;

  //text fields
  var nameController = TextEditingController();
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();

  //shop controllers
  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDesController = TextEditingController();

  var profileImgPath = ''.obs;
  var profileImageLink = ''.obs;
  var isloading = false.obs;
  var vendorId = '';

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink.value = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(vendorsCollection).doc(vendorId);
    await store
        .set({'vendor_name': name, 'password': password, 'imageUrl': imgUrl});
    SetOptions(merge: true);
  }

  changeAuthPassword({email, oldPassword, newPassword}) async {
    final cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {});
  }

  updateShop({shopname, shopaddress, shopmobile, shopwebsite, shopdesc}) async {
    var store = firestore.collection(vendorsCollection).doc(vendorId);
    await store.set({
      'shop_name': shopname,
      'shop_address': shopaddress,
      'shop_mobile': shopmobile,
      'shop_website': shopwebsite,
      'shop_desc': shopdesc
    }, SetOptions(merge: true));
  }
  // updateShop({shopname, shopaddress, shopmobile, shopwebsite, shopdesc}) async {
  //   var querySnapshot = await firestore
  //       .collection(vendorsCollection)
  //       .where('id', isEqualTo: currentUser!.uid)
  //       .get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     var doc = querySnapshot.docs.first;
  //     await doc.reference.set({
  //       'shop_name': shopname,
  //       'shop_address': shopaddress,
  //       'shop_mobile': shopmobile,
  //       'shop_website': shopwebsite,
  //       'shop_desc': shopdesc
  //     }, SetOptions(merge: true));
  //   }
  // }

  //this is used to get specific seller doc id
  Future<String?> getVendorDocumentId() async {
    var querySnapshot = await firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      vendorId = querySnapshot.docs.first.id;

      return vendorId;
    } else {
      return null;
    }
  }
}
