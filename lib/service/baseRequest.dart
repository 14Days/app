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
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.json,
    ));
  }

  Future<Response<T>> get<T>(String path, {dynamic queryParameters}) async {
    var getToken = await SharedPreferences.getInstance();
    var token = getToken.get(_token);
    return await _base.get(path, queryParameters: queryParameters, options: Options(
      headers: {
        'Authorization': token
      },
    ));
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    var getToken = await SharedPreferences.getInstance();
    var token = getToken.get(_token);
    return await _base.post(path, data: data, options: Options(
      headers: {
        'Authorization': token
      },
    ));
  }

  Future<Response<T>> delete<T>(String path, {dynamic queryParameters}) async {
    var getToken = await SharedPreferences.getInstance();
    var token = getToken.get(_token);
    return await _base.delete(path, queryParameters: queryParameters, options: Options(
      headers: {
        'Authorization': token
      },
    ));
  }
}
