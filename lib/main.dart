import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:time_checker/bloc/auth_bloc.dart';
import 'package:time_checker/service/app/app.dart';
import 'package:time_checker/service/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule(); // GetIt тохируулах
  // GetIt тохиргоо болон бүртгэлүүдийг дуудна

  runApp(BlocProvider(
    create: (context) => AuthBloc()..add(AppStarted()),
    child: MyApp(),
  ));
}
