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
    // lang = 'en',
    // token = '',
  })async{
    // dio?.options.headers = {
      // 'lang' : lang,
      // 'authorization' : token,
    // };
    return dio?.get(
        url,
        queryParameters: query
    );
  }
  static Future<Response?> postData({
    required String url,
    data,
    lang = 'en',
    token = ''
  })async {
    dio?.options.headers = {
      'lang' : lang,
      'authorization' : token,
    };
    return dio?.post(
      url,
      data: data,
    );
  }
}