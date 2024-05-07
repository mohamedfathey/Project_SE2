import 'package:amazon/constant/common_function.dart';
import 'package:amazon/controller/services/auth_services.dart';
import 'package:amazon/controller/services/login_bloc/login_bloc.dart';
import 'package:amazon/utils/colors.dart';
import 'package:amazon/view/home_screen.dart';
import 'package:amazon/view/otp_screen.dart';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthServices _authServices = AuthServices();

  bool inLogin = false;
  String CurrentCountryCode = '+20';
  TextEditingController mobileController = TextEditingController();
  TextEditingController namedController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/amazon_logo.png',
          height: height * 0.04,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: textThem.displaySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                CommonFunction.blankSpace(height * 0.02, 0),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    String message = "";
                    if (state is ExceptionState) {
                      message = state.message;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(message), const Icon(Icons.error)],
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state is OtpExceptionState) {
                      message = state.message;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(message), const Icon(Icons.error)],
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state is LoginCompleteState) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          child: const HomeScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is OtpSentState ||
                          state is OtpExceptionState) {
                        return Expanded(
                          child: OTPScreen(
                            mobileNumber:
                                '$CurrentCountryCode${mobileController.text.trim()}',
                          ),
                        );
                      }

                      return Builder(builder: (context) {
                        if (!inLogin) {
                          return SignIn(width, height, textThem, context);
                        } else {
                          return CreateAcount(width, height, textThem, context);
                        }
                      });
                    },
                  ),
                ),
                CommonFunction.blankSpace(height * 0.05, 0),
                const BottomAuthScreenWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container SignIn(
      double width, double height, TextTheme textTheme, BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: greyShade3,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
              width: width,
              child: Text('  New To Amazon ?', style: textTheme.bodyMedium!)),
          Container(
            height: height * 0.06,
            width: width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: greyShade3),
              ),
              color: greyShade1,
            ),
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inLogin = true;
                    });
                  },
                  child: Container(
                    height: height * 0.03,
                    width: height * 0.03,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: grey,
                        ),
                        color: white),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.circle,
                      size: height * 0.015,
                      color: inLogin ? secondaryColor : transparent,
                    ),
                  ),
                ),
                CommonFunction.blankSpace(
                  0,
                  width * 0.02,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Create Account.',
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.01,
            ),
            child: Column(
              children: [
                SizedBox(
                    width: width,
                    child: Text('Already a Customer',
                        style: textTheme.bodyMedium!)),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          inLogin = false;
                        });
                      },
                      child: Container(
                        height: height * 0.03,
                        width: height * 0.03,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: grey,
                            ),
                            color: white),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.circle,
                          size: height * 0.015,
                          color: !inLogin ? secondaryColor : transparent,
                        ),
                      ),
                    ),
                    CommonFunction.blankSpace(
                      0,
                      width * 0.02,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (val) {
                            setState(() {
                              CurrentCountryCode = '+${val.phoneCode}';
                            });
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.06,
                        width: width * 0.2,
                        decoration: BoxDecoration(
                          color: greyShade2,
                          border: Border.all(
                            color: greyShade3,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          CurrentCountryCode,
                          style: textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                      width: width * 0.63,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                        cursorColor: Colors.black,
                        style: textTheme.displaySmall,
                        cursorHeight: 26,
                        decoration: InputDecoration(
                          hintText: 'Mobile number',
                          hintStyle: textTheme.bodySmall,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: secondaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CommonFunction.blankSpace(
                  height * 0.02,
                  0,
                ),
                Center(
                  child: CommonAuthButton(
                    title: 'Continue',
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(SendOtpEvent(
                          phoNo:
                              '$CurrentCountryCode${mobileController.text.trim()}'));
                    },
                  ),
                ),
                CommonFunction.blankSpace(
                  height * 0.02,
                  0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By Continue you agree to Amazon\'s ',
                        style: textTheme.labelMedium,
                      ),
                      TextSpan(
                        text: 'Condition of use',
                        style: textTheme.labelMedium!.copyWith(
                          color: blue,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: textTheme.labelMedium,
                      ),
                      TextSpan(
                        text: 'Privacy Notice',
                        style: textTheme.labelMedium!.copyWith(
                          color: blue,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //create Account
  Container CreateAcount(
      double width, double height, TextTheme textTheme, BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: greyShade3,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.01,
            ),
            child: Column(
              children: [
                SizedBox(
                    width: width,
                    child: Text('New to Amazon', style: textTheme.bodyMedium!)),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          inLogin = true;
                        });
                      },
                      child: Container(
                        height: height * 0.03,
                        width: height * 0.03,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: grey,
                            ),
                            color: white),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.circle,
                          size: height * 0.015,
                          color: !inLogin ? transparent : secondaryColor,
                        ),
                      ),
                    ),
                    CommonFunction.blankSpace(
                      0,
                      width * 0.02,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Create Account.',
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                SizedBox(
                  height: height * 0.06,
                  width: width * 0.82,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: namedController,
                    cursorColor: Colors.blue,
                    style: textTheme.displaySmall,
                    cursorHeight: 26,
                    decoration: InputDecoration(
                      hintText: 'First and Last name',
                      hintStyle: textTheme.bodySmall,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: grey),
                      ),
                    ),
                  ),
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (val) {
                            setState(() {
                              CurrentCountryCode = '+${val.phoneCode}';
                            });
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.06,
                        width: width * 0.2,
                        decoration: BoxDecoration(
                          color: greyShade2,
                          border: Border.all(
                            color: greyShade3,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          CurrentCountryCode,
                          style: textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                      width: width * 0.63,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                        cursorColor: Colors.blue,
                        style: textTheme.displaySmall,
                        cursorHeight: 26,
                        decoration: InputDecoration(
                          hintText: 'Mobile number',
                          hintStyle: textTheme.bodySmall,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: secondaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CommonFunction.blankSpace(
                  height * 0.02,
                  0,
                ),
                Text(
                  'By enrolling your mobile phone number, you concent to receive automated security notifications via text message from Amazon.\n Message and data rates may apply',
                  style: textTheme.bodyMedium,
                ),
                CommonFunction.blankSpace(
                  height * 0.02,
                  0,
                ),
                CommonAuthButton(
                  title: 'Continue',
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(SendOtpEvent(
                        phoNo:
                            '$CurrentCountryCode${mobileController.text.trim()}'));
                  },
                ),
                CommonFunction.blankSpace(
                  height * 0.02,
                  0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By Continue you agree to Amazon\'s ',
                        style: textTheme.labelMedium,
                      ),
                      TextSpan(
                        text: 'Condition of use',
                        style: textTheme.labelMedium!.copyWith(
                          color: blue,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: textTheme.labelMedium,
                      ),
                      TextSpan(
                        text: 'Privacy Notice',
                        style: textTheme.labelMedium!.copyWith(
                          color: blue,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
              width: width,
              child: Text('Already a Customer', style: textTheme.bodyMedium!)),
          Container(
            height: height * 0.06,
            width: width,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: greyShade3),
              ),
              color: greyShade1,
            ),
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inLogin = false;
                    });
                  },
                  child: Container(
                    height: height * 0.03,
                    width: height * 0.03,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: grey,
                        ),
                        color: white),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.circle,
                      size: height * 0.015,
                      color: inLogin ? transparent : secondaryColor,
                    ),
                  ),
                ),
                CommonFunction.blankSpace(
                  0,
                  width * 0.02,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sign in.',
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonAuthButton extends StatelessWidget {
  CommonAuthButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  String title;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textThem = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width * 0.80, height * 0.06),
        backgroundColor: amber,
      ),
      child: Text(title, style: textThem.displaySmall!),
    );
  }
}

class BottomAuthScreenWidget extends StatelessWidget {
  const BottomAuthScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textThem = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          height: 2,
          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [white, greyShade3, white])),
        ),
        CommonFunction.blankSpace(
          height * 0.02,
          0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Condition of Use',
              style: textThem.bodyMedium!.copyWith(color: blue),
            ),
            Text(
              'Privacy Notice',
              style: textThem.bodyMedium!.copyWith(color: blue),
            ),
            Text(
              'Help',
              style: textThem.bodyMedium!.copyWith(color: blue),
            ),
          ],
        ),
        CommonFunction.blankSpace(
          height * 0.01,
          0,
        ),
        Text(
          '@ 1996-2024, Amazon.com , Inc. or its affiliates',
          style: textThem.labelMedium!.copyWith(
            color: grey,
          ),
        ),
      ],
    );
  }
}
