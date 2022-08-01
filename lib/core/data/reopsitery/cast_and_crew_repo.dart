import 'package:flutter/cupertino.dart';

import '../../models/Credits.dart';
import '../dio/dio_helper.dart';
import '../dio/end_points.dart';

class CastRepo {
  static Future<Credits> Cast(movieId) {
    return DioHelper.getData(
        url: 'movie/$movieId/credits', query: {'api_key': apiKey,}).then((value) {
      return Credits.fromJson(value?.data);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  static Future<Credits> Crew(tvId) {
    return DioHelper.getData(
        url: 'tv/$tvId/credits', query: {'api_key': apiKey,}).then((value) {
      return Credits.fromJson(value?.data);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}