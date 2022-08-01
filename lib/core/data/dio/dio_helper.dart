import 'package:dio/dio.dart';
class DioHelper {
  static Dio? dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        receiveDataWhenStatusError: true,
      )
    );
  }
  static Future<Response?> getData({
    required String url,
    query,
  })async{
    return dio?.get(
        url,
        queryParameters: query
    );
  }
  static Future<Response?> postData({
    required String url,
    data,
  })async {
    return dio?.post(
      url,
      data: data,
    );
  }
}