import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/modules/info_screen.dart';
import 'package:movies_app/shared/cubit/app_cubit.dart';
import 'package:movies_app/shared/cubit/app_states.dart';

import 'modules/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Movies App',
              theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent
                      )
                  )
              ),
              initialRoute: '/',
              routes: {
                '/HomeScreen': (context) => HomeScreen(),
                '/InfoScreen': (context) => InfoScreen(),
              },
              home: const HomeScreen(),
            );
          }
      ),
    );
  }
}

