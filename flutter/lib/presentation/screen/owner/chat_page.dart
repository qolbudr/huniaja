import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/firebase_service.dart';
import 'package:manpro/presentation/widget/input.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.chatId, this.userName, this.userId, this.face});
  final String chatId;
  final String face;
  final String userName;
  final int userId;
  final messageController = TextEditingController();

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(userName),
            elevation: 0,
          ),
          body: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseService().getChat(chatId),
                builder: (context, snapshot) {
                  if(snapshot.data == null) {
                    return Expanded(
                      child: Column(
                        children: [
                          LinearProgressIndicator(minHeight: 2),
                          Expanded(child: Container())
                        ],
                      ),
                    );
                  } else {
                    var data = snapshot.data.docs;
                    return Expanded(
                      child: ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.all(10),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var result = data[index];
                          if(result['sender'] == authLogin.authLogin.user.id) {
                            return Row(
                              children: [
                                Expanded(child: SizedBox()),
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: primaryColor,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(result["message"], style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: accentColor,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(result["message"]),
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            );
                          }
                        },
                      ),
                    );
                  }
                }
              ),
              Container(
                height: 80,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: InputIcon(icon: Icons.email, hintText: "Ketik pesan...", controller: messageController)),
                    CircleIconButton(icon: Icons.send, size: 25, color: primaryColor, onPressed: () {
                      FirebaseService().sendOwnerChat(
                        face: face,
                        message: messageController.text,
                        ownerId: authLogin.authLogin.user.id,
                        ownerName: authLogin.authLogin.user.name,
                        userId: userId,
                        userName: userName,
                        chatId: chatId
                      );
                      messageController.text = "";
                    })
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}