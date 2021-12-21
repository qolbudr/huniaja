import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manpro/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:manpro/service/firebase_service.dart';
import 'package:manpro/presentation/screen/owner/chat_page.dart';


class TabOwnerChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseService().getListChat(authLogin.authLogin.user.id),
          builder: (context, snapshot) {
            if(snapshot.data == null) {
              return LinearProgressIndicator(minHeight: 2);
            } else {
              var result = snapshot.data.docs;
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 0),
                itemCount: result.length, 
                itemBuilder: (context, index) {
                  var data = result[index];
                  return ListTile(
                    // hoverColor: Colors.black.withOpacity(0.3),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ChatPage(chatId: data.id, userName: data['userName'], userId: data['userId'], face: data['face'])
                    )),
                    title: Text(data['userName']),
                    subtitle: Text(data['message']),
                  );
                }
              );
            }
          }
        );
      }
    );
  }
}