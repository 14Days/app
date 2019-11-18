import 'package:dio/dio.dart';
import 'package:furture/service/serviceUrl.dart';
import 'dart:async';
import 'serviceUrl.dart';
import './baseRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';
//登录请求
Future loginService(String username, String password) async {
  try {
    //要传递的参数
    var loginParam = {"username": username, "password": password};
    //获取请求
    Response response =
        await BaseRequest().post(servicePath[login], data: loginParam);

    if (response.statusCode == 200) {
      var setToken = await SharedPreferences.getInstance();
      setToken.setString('token', response.data['data'].toString());
      return response.data;
    } else {
      throw Exception("登录请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//验证码请求
Future codeService(String phone) async {
  try {
    //要传递的参数
    var codeParam = {"phone": phone};
    //获取请求
    Response response = await BaseRequest()
        .delete(servicePath[code], queryParameters: codeParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("验证码请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//注册请求
Future registerService(
    String username, String password, String phone, String code) async {
  try {
    //要传递的参数
    var registerParam = {
      "username": username,
      "password": password,
      "phone": phone,
      "code": code
    };
    //获取请求
    Response response =
        await BaseRequest().post(servicePath[register], data: registerParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("注册请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}
