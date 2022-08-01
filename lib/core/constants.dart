import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String token = '';
List<bool> selectedCategory = List.filled(20, false);

List<String> trendingCat = ['All', 'Movies', 'TV Shows', 'People'];
List<String> trendingCatDay = ['Day', 'Week'];
bool isPerson = false;

AppBarTheme theme =  const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    )
);

double getNumber(double input, {int precision = 1}) =>
    double.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));

void bigPrint(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
}