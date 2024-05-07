part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {
  final String role;

  const Authenticated({required this.role});

  @override
  List<Object> get props => [role];
}

final class Unauthenticated extends AuthState {}

final class Loading extends AuthState {}
