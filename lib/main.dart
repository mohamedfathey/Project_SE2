import 'package:amazon/controller/provider/auth_provider.dart';
import 'package:amazon/controller/services/auth_bloc/auth_bloc.dart';
import 'package:amazon/controller/services/login_bloc/login_bloc.dart';
import 'package:amazon/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
      ),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
      ),
    ],
    child: const Amazon(),
  ));
}

class Amazon extends StatefulWidget {
  const Amazon({super.key});

  @override
  State<Amazon> createState() => _AmazonState();
}

class _AmazonState extends State<Amazon> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(AppStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return const HomeScreen();
          } else if (state is Unauthenticated) {
            return const AuthScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      // home: UserBottomNavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
