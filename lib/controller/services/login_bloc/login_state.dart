part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class OtpSentState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginCompleteState extends LoginState {
  const LoginCompleteState();

  @override
  List<Object> get props => [];
}

class ExceptionState extends LoginState {
  final String message;

  const ExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}

class OtpExceptionState extends LoginState {
  final String message;

  const OtpExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
