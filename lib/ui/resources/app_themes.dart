import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/ui/resources/app_colors.dart';

ThemeData appThemes(){
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            // statusBarColor: Colors.transparent
        )
    )
  );
}