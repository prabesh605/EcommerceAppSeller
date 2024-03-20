import 'package:ecommerce_seller_app/consts/firebase_consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var navIndex = 0.obs;
  var username = '';
  int? totalProducts;
  int? totalOrders;
  int? totalSales;
  @override
  void onInit() {
    super.onInit();
    getUsername();
    getTotalProducts();
    getTotalOrders();
    getTotalSales();
  }

  getTotalProducts() async {
    var t = await firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: currentUser!.uid)
        .get();
    totalProducts = t.size;
  }

  getTotalOrders() async {
    var querySnapshot = await firestore
        .collection('orders')
        .where('orders', arrayContains: {'vendor_id': currentUser!.uid}).get();

    totalOrders = querySnapshot.size;
  }

  getTotalSales() async {
    var sales = await firestore
        .collection(productsCollection)
        .where('order_delivered', isEqualTo: true)
        .get();
    totalSales = sales.size;
  }

  getUsername() async {
    var n = await firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });
    username = n;
  }
}
