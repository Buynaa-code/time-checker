import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:time_checker/bloc/auth_bloc.dart';

import 'package:time_checker/screens/login/login_screen.dart';
import 'package:time_checker/screens/main/home_screen.dart';
import 'package:time_checker/screens/onboarding_screen.dart';
import 'package:time_checker/screens/widget/bottom_navigation.dart';

class MyApp extends StatefulWidget {
  static String url = 'https://office.jbch.mkh.mn/api';
  static bool debug = true;

  MyApp({super.key}) {
    if (debug) {
      url = 'https://office.jbch.mkh.mn/api';
    } else {
      url = 'https://office.jbch.mkh.mn/api';
    }
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Register services
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is MeInfoLoaded) {
            return const HomeScreen();
          } else if (state is AuthPageLoaded) {
            return const LoginScreen();
          }
          return const OnboardingScreen();
        },
      ),
    );
  }
}
