import 'dart:developer';

import 'package:amazon/controller/services/auth_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String verID = "";
  final AuthServices authServices = AuthServices();

  LoginBloc() : super(LoginInitial()) {
    on<SendOtpEvent>((event, emit) {
      emit(LoadingState());
      sendOtp(event.phoNo);
    });

    on<OtpSendEvent>((event, emit) {
      emit(OtpSentState());
    });

    on<LoginCompleteEvent>((event, emit) async {
      final String role = await authServices.getRole();
      emit(LoginCompleteState(role));
    });

    on<LoginExceptionEvent>((event, emit) {
      emit(ExceptionState(message: event.message));
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(LoadingState());
      try {
        authServices.verifyAndLogin(verID, event.otp);
        final String role = await authServices.getRole();
        emit(LoginCompleteState(role));
      } catch (e) {
        emit(const OtpExceptionState(message: "Invalid otp!"));
        print(e);
      }
    });
  }

  void sendOtp(String phoNo) async {
    phoneVerificationCompleted(AuthCredential authCredential) {
      User user = authServices.getUser()!;
      add(LoginCompleteEvent(user));
    }

    phoneVerificationFailed(FirebaseException authException) {
      print(authException.message);
      add(LoginExceptionEvent(onError.toString()));
    }

    phoneCodeSent(String verId, [int? forceResent]) {
      verID = verId;
      add(OtpSendEvent());
    }

    phoneCodeAutoRetrievalTimeout(String verid) {
      verID = verid;
    }

    await authServices.sendOtp(
        phoNo,
        const Duration(seconds: 120),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);
  }
}
