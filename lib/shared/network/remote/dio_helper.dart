import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String,dynamic> query,
  })
  async {
    return await dio.get(url, queryParameters: query);
  }
}


//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=12e8cc2548a94339a9ed3f753b14de5f