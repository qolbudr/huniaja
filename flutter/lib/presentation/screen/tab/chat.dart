import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manpro/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:manpro/service/firebase_service.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/presentation/screen/chat_page.dart';
import 'package:lottie/lottie.dart';


class TabChat extends StatelessWidget {
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
              if(result.length > 0) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: result.length, 
                  itemBuilder: (context, index) {
                    var data = result[index];
                    return ListTile(
                      // hoverColor: Colors.black.withOpacity(0.3),
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ChatPage(chatId: data.id, ownerName: data['ownerName'], ownerId: data['ownerId'])
                      )),
                      title: Text(data['ownerName']),
                      subtitle: Text(data['message']),
                    );
                  }
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.network('https://assets6.lottiefiles.com/packages/lf20_t24tpvcu.json'),
                      Text("Belum ada chat", style: textTheme.headline6)
                    ]
                  )
                );
              }
            }
          }
        );
      }
    );
  }
}