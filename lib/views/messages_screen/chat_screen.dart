import 'package:ecommerce_seller_app/views/messages_screen/components/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 214, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 162, 206, 243),
        title: "Messages".text.bold.size(16).make(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return chatBubble();
                }),
          ),
          10.heightBox,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  // controller: controller.msgController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      hintText: "Type a message......."),
                ),
              ),
              IconButton(
                onPressed: () {
                  // controller.sendMsg(controller.msgController.text);
                  // controller.msgController.clear();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.red,
                ),
              ),
            ],
          )
              .box
              .height(70)
              .color(
                const Color.fromARGB(255, 162, 206, 243),
              )
              .padding(const EdgeInsets.all(12))
              .make()
        ],
      ),
    );
  }
}
