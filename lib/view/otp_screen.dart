import 'dart:developer';

import 'package:amazon/constant/common_function.dart';
import 'package:amazon/controller/blocs/login_bloc/login_bloc.dart';
import 'package:amazon/controller/services/auth_services.dart';
import 'package:amazon/main.dart';
import 'package:amazon/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/colors.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({super.key, required this.mobileNumber});
  String mobileNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  AuthServices _authServices = AuthServices();

  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: Image(
          image: const AssetImage('assets/images/amazon_logo.png'),
          height: height * 0.04,
        ),
      ),
      body: SafeArea(
        child: ListView(children: [
          Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Authentication Required',
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CommonFunctions.blankSpace(
                  height * 0.01,
                  0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.mobileNumber,
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' Change',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                CommonFunctions.blankSpace(
                  height * 0.02,
                  0,
                ),
                Text(
                  'We have send a One Time Password (OTP) to the mobile no. above. Please enter it to complete verification.',
                  style: textTheme.bodyMedium,
                ),
                CommonFunctions.blankSpace(
                  height * 0.02,
                  0,
                ),
                TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    hintStyle: textTheme.bodySmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: secondaryColor,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                  ),
                ),
                CommonFunctions.blankSpace(
                  height * 0.01,
                  0,
                ),
                Center(
                  child: CommonAuthButton(
                    title: 'Continue',
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(VerifyOtpEvent(otp: otpController.text.trim()));
                    },
                  ),
                ),
                CommonFunctions.blankSpace(
                  height * 0.01,
                  0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend OTP',
                        style: textTheme.bodyMedium!.copyWith(
                          color: blue,
                        ),
                      ),
                    ),
                  ],
                ),
                CommonFunctions.blankSpace(
                  height * 0.02,
                  0,
                ),
                const BottomAuthScreenWidget()
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
