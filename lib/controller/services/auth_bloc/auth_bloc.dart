import 'package:amazon/controller/services/auth_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authServices = AuthServices();
  AuthBloc() : super(AuthInitial()) {
    on<AppStartEvent>((event, emit) async {
      String role = "";
      final bool hasUser = authServices.getUser() != null;
      if (hasUser) {
        role = await authServices.getRole();
        emit(Authenticated(role: role));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
