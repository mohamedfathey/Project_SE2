import 'package:amazon/controller/blocs/auth_bloc/auth_bloc.dart';
import 'package:amazon/controller/blocs/login_bloc/login_bloc.dart';
import 'package:amazon/controller/provider/Product_Provider.dart';
import 'package:amazon/controller/provider/auth_provider.dart';
import 'package:amazon/controller/provider/deal_of_the_provider.dart';
import 'package:amazon/controller/provider/product_by_category_provider.dart';
import 'package:amazon/controller/provider/rating_provider.dart';
import 'package:amazon/controller/provider/users_product_provider.dart';

import 'package:amazon/utils/theme.dart';
import 'package:amazon/view/Home/component/user_bottom_nav_bar.dart';
import 'package:amazon/view/auth_screen.dart';
import 'package:amazon/view/home_screen.dart';
import 'package:amazon/view/seller/seller_persistant_nav_bar/seller_bottom_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
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
    child: MultiProvider(providers: [
      ChangeNotifierProvider<SellerProductProvider>(
          create: (_) => SellerProductProvider()),
      ChangeNotifierProvider<UsersProductProvider>(
          create: (_) => UsersProductProvider()),
      ChangeNotifierProvider<DealOfTheDayProvider>(
          create: (_) => DealOfTheDayProvider()),
      ChangeNotifierProvider<ProductsBasedOnCategoryProvider>(
          create: (_) => ProductsBasedOnCategoryProvider()),
      ChangeNotifierProvider<RatingProvider>(create: (_) => RatingProvider()),
    ], child: const Amazon()),
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
            if (state.role == "user") {
              return const UserBottomNavBar();
            } else {
              return const SellerBottomNavBar();
            }
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
