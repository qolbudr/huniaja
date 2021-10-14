import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getListChat(int userId)  {
    return _db.collection('chat').where('sender', arrayContains: userId).snapshots();
  }

  Stream<DocumentSnapshot> getChatOwner(int userId, int ownerId)  {
    return _db.collection('chat').doc("$ownerId:$userId").snapshots();
  }

  Stream<QuerySnapshot> getChat(String id) {
    return _db.collection('chat').doc(id).collection('messages').orderBy('date', descending: true).snapshots();
  }

  void sendChat({String face, String message, int ownerId, String ownerName, int userId, String userName, String chatId}) {
    _db.collection('chat').doc(chatId).set({
      "date": DateTime.now().millisecondsSinceEpoch,
      "face": face,
      "message": message,
      "ownerId": ownerId,
      "ownerName": ownerName,
      "sender": [
        ownerId,
        userId
      ],
      "userId": userId,
      "userName": userName,
    }, SetOptions(merge: true));

    _db.collection('chat').doc(chatId).collection('messages').add({
      "message": message,
      "sender": userId,
      "date": DateTime.now().millisecondsSinceEpoch
    });
  }

  void sendOwnerChat({String face, String message, int ownerId, String ownerName, int userId, String userName, String chatId}) {
    _db.collection('chat').doc(chatId).set({
      "date": DateTime.now().millisecondsSinceEpoch,
      "face": face,
      "message": message,
      "ownerId": ownerId,
      "ownerName": ownerName,
      "sender": [
        ownerId,
        userId
      ],
      "userId": userId,
      "userName": userName,
    }, SetOptions(merge: true));

    _db.collection('chat').doc(chatId).collection('messages').add({
      "message": message,
      "sender": ownerId,
      "date": DateTime.now().millisecondsSinceEpoch
    });
  }
}