import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // Hozirgi user

  User? getCurrentUser(){
    return _auth.currentUser;
  }



  // REGISTER
  Future<UserCredential> register(String email, String pw) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: pw
      );

      // malumot saqlash
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            "uid" : userCredential.user!.uid,
            "email" : email
          }
      );

      return userCredential;
    } on FirebaseAuthException catch(error){
      throw Exception(error.code);
    }
  }

  // LOGIN
  Future<UserCredential> login(String email, String pw) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: pw
      );

      // agar bunaqa foydalanuvchi yo'q bo'lsa saqlaymiz
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            "uid" : userCredential.user!.uid,
            "email" : email
          }
      );

      return userCredential;
    } on FirebaseAuthException catch(error){
      throw Exception(error.code);
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // SHORT ERROR MESSAGES
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return "Bunday foydalanuvchi topilmadi";
      case 'wrong-password':
        return "Parol noto‘g‘ri";
      case 'email-already-in-use':
        return "Email band qilingan";
      case 'weak-password':
        return "Parol juda oddiy";
      case 'invalid-email':
        return "Email noto‘g‘ri formatda";
      default:
        return "Xatolik yuz berdi";
    }
  }
}