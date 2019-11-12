import 'package:dio/dio.dart';
import 'package:furture/service/serviceUrl.dart';
import 'dart:async';
import 'serviceUrl.dart';

//import 'dart:convert';
//

BaseOptions options = new BaseOptions(
  baseUrl: baseUrl,
  contentType: 'application/json',
  connectTimeout: 50000,
  receiveTimeout: 3000,
);
Dio dio = new Dio(options);

//登录请求
Future loginService(String username, String password) async {
  try {
    //要传递的参数
    var login = {"username": username, "password": password};
    //获取请求
    Response response = await dio.post(servicePath['login'], data: login);
    if (response.statusCode == 200) {
      print("登录请求！！！！");
      return response.data;
    } else {
      throw Exception("登录请求异常");
    }
  } catch(e) {
    return print('Error------------->$e');
  }
}

//验证码请求
Future codeService(String phone) async {
  try {
    //要传递的参数
    var code = {"phone": phone};
    //获取请求
    Response response = await dio.post(servicePath['code'], data: code);
    if (response.statusCode == 200) {
      print("验证码请求成功！！！！");
      return response.data;
    } else {
      throw Exception("验证码请求异常");
    }
  } catch(e) {
    return print('Error------------->$e');
  }
}

//注册请求
Future registerService(String username, String password, String phone, String code) async {
  try {
    //要传递的参数
    var register = {"username": username, "password": password, "phone": phone, "code": code};
    //获取请求
    Response response = await dio.post(servicePath['register'], data: register);
    if (response.statusCode == 200) {
      print("注册请求成功！！！！");
      return response.data;
    } else {
      throw Exception("注册请求异常");
    }
  } catch(e) {
    return print('Error------------->$e');
  }
}

//找回密码请求
Future findPwdService(String password, String phone, String code) async {
  try {
    //要传递的参数
    var findPwd = {"password": password, "phone": phone, "code": code};
    //获取请求
    Response response = await dio.post(servicePath['register'], data: findPwd);
    if (response.statusCode == 200) {
      print("注册请求成功！！！！");
      return response.data;
    } else {
      throw Exception("注册请求异常");
    }
  } catch(e) {
    return print('Error------------->$e');
  }
}
