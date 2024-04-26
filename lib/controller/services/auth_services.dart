// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:amazon/controller/provider/auth_provider.dart';
import 'package:amazon/view/otp_screen.dart';
import 'package:amazon/view/sign_logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AuthServices {
  static bool checkAuthentication() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  static receiveOTP(
      {required BuildContext context, required String mobileNo}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNo,
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Error the provided number not valid')));
          }else {
             ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Something went wrong try again')));
          }
        },
        codeSent: (String verificationID, int? resendToken) {
          context
              .read<Authprovider>()
              .upDateverificationId(verID: verificationID);
          context.read<Authprovider>().upDatePhoneNumber(
                num: mobileNo,
              );
          Navigator.push(
            context,
            PageTransition(
              child: OTPScreen(mobileNumber: mobileNo),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<Authprovider>().verificationId,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.push(
          context,
          PageTransition(
            child: SignLogic(),
            type: PageTransitionType.rightToLeft,
          ));
    } catch (e) {
      log(e.toString());
    }
  }
}
