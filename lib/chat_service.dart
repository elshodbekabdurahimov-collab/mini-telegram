import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telegram/message.dart';

class ChatService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getAllUsers() {
    return FirebaseFirestore.instance
        .collection("Users")
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }


  Future<void> sendMessage(String recieverID, message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String? currentUserEmail = _auth.currentUser!.email;
    final Timestamp time = Timestamp.now();

    Message newMessage = Message(
        senderID: currentUserId,
        senderEmail: currentUserEmail!,
        recieverID: recieverID,
        messageText: message,
        time: time
    );


    List<String> IDs = [currentUserId, recieverID];
    IDs.sort();
    String chatRoomId = IDs.join('_');

    // databazaga saqlash
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());

  }


  // xabarni ko'rish
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    List<String> IDs = [userID, otherUserID];
    IDs.sort();
    String chatRoomId = IDs.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("time", descending: false)
        .snapshots();
  }

}