import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3/movie/',
          receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData({
    String? url,
  }) async {
    return await dio!.get(
      url!,
      queryParameters: {
        'api_key': '5e22f2f2eead68ba3c6343a61ff127e8',
      },
    );
  }
}
