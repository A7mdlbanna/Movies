import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/modules/info_screen.dart';

import 'modules/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        '/HomeScreen' : (context) => HomeScreen(),
        '/InfoScreen' : (context) => InfoScreen(),
      },
      home: const HomeScreen(),
    );
  }
}

