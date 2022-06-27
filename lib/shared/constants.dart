import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String token = '';
List<bool> selectedCategory = List.filled(10, false);

AppBarTheme theme =  const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    )
);