import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/consts/firebase_consts.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/messages_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Messages".text.bold.size(16).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> Snapshot) {
            if (!Snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = Snapshot.data!.docs;
              return Column(
                children: List.generate(data.length, (index) {
                  var t = data[index]['created_on'] == null
                      ? DateTime.now()
                      : data[index]['created_on'].toDate();
                  var time = intl.DateFormat('h:mma').format(t);
                  return ListTile(
                    onTap: () {
                      Get.to(() => const ChatScreen());
                    },
                    leading: const CircleAvatar(
                      backgroundColor: Colors.purpleAccent,
                      child: Icon(Icons.person),
                    ),
                    title: "${data[index]['sender_name']}".text.bold.make(),
                    subtitle: "${data[index]['last_msg']}".text.make(),
                    trailing: time.text.make(),
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
