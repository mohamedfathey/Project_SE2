// ignore_for_file: file_names, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:amazon/constant/common_function.dart';
import 'package:amazon/constant/constants.dart';
import 'package:amazon/model/user_model.dart';
import 'package:amazon/view/Home/HomeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class UserDataCRUD {
  static Future addNewUser({
    required UserModel userModel,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.phoneNumber)
          .set(userModel.toMap())
          .whenComplete(() {
        log('Data Added');
        CommonFunctions.showSuccessToast(
            context: context, message: 'User Added Successful');
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const HomeScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
      CommonFunctions.showErrorToast(context: context, message: e.toString());
    }
  }

  static Future<bool> checkUser() async {
    bool userPresent = false;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('mobileNum', isEqualTo: auth.currentUser!.phoneNumber)
          .get()
          .then((value) {
        value.size > 0 ? userPresent = true : userPresent = false;
        log(value.toString());
      });
    } catch (e) {
      log(e.toString());
    }
    log(userPresent.toString());
    return userPresent;
  }

  static Future<bool> userIsSeller() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(auth.currentUser!.phoneNumber)
          .get();
      if (snapshot.exists) {
        UserModel userModel = UserModel.fromMap(snapshot.data()!);
        log('User Type is: ${userModel.userType!}');
        if (userModel.userType != 'user') {
          return true;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
