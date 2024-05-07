// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:amazon/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

/*   Future<UserModel?> signUp(
      String email, String password, String phone, String role) async {
    final UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(email: email, password: password);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user!.uid)
        .set({
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'cart': []
    });
    return UserModel(
      id: userCredential.user?.uid,
      phone: userCredential.user?.phoneNumber ?? "",
      email: userCredential.user?.email ?? '',
      displayName: userCredential.user?.displayName ?? '',
    );
  }

  Future<UserModel?> login(String email, String password) async {
    final UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return UserModel(
      id: userCredential.user?.uid,
      phone: userCredential.user?.phoneNumber ?? "",
      email: userCredential.user?.email ?? '',
      displayName: userCredential.user?.displayName ?? '',
    );
  } */

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  void verifyAndLogin(String verificationId, String smsCode) async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      auth.signInWithCredential(authCredential);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set({
        'phone': auth.currentUser!.phoneNumber,
        'role': "user",
        'cart': []
      });
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }

  User? getUser() {
    var user = auth.currentUser;
    return user;
  }

  Future<String> getRole() async {
    final DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    String role = snap.data()?['role'];
    return role;
  }
}
