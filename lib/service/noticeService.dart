import 'package:dio/dio.dart';
import 'package:furture/service/serviceUrl.dart';
import 'dart:async';
import 'serviceUrl.dart';
import './baseRequest.dart';

//通知请求
Future noticeService() async {
  try {
    //获取请求
    Response response = await new BaseRequest().get(servicePath[notice]);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("通知请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}
