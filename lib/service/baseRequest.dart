import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseRequest {
  final _baseUrl = "https://wghtstudio.cn/app";
  final String _token = 'token';
  Dio _base;

  BaseRequest() {
    _base = new Dio(BaseOptions(
      baseUrl: _baseUrl,
      contentType: 'application/json',
      connectTimeout: 50000,
      receiveTimeout: 3000,
      responseType: ResponseType.json,
    ));
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic> query}) async {
    var getToken = await SharedPreferences.getInstance();
    var token = getToken.get(_token);
    return await _base.get(path, queryParameters: query, options: Options(
      headers: {
        'Authorization': token
      },
    ));
  }

  Future<Response<T>> post<T>(String path, Map<String, dynamic> data) async {
    return await _base.post(path, data: data);
  }
}
