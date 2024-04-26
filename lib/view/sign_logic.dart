
import 'package:amazon/controller/services/auth_services.dart';
import 'package:amazon/view/auth_screen.dart';
import 'package:amazon/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignLogic extends StatefulWidget {
  const SignLogic({Key? key});

  @override
  State<SignLogic> createState() => _SignLogicState();
}

class _SignLogicState extends State<SignLogic> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      CheckAuthentication();
    });
  }

  void CheckAuthentication() {
    bool userIsAuthenticated = AuthServices.checkAuthentication();
    if (userIsAuthenticated) {
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.rightToLeft,
        ),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: AuthScreen(),
          type: PageTransitionType.rightToLeft,
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Scaffold in SignLogic'),
      ),
    );
  }
}
