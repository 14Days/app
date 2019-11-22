import 'package:dio/dio.dart';
import 'package:furture/service/serviceUrl.dart';
import 'dart:async';
import 'serviceUrl.dart';
import './baseRequest.dart';

//请求推荐消息
Future homeRecommendService() async {
  try {
    Response response = await BaseRequest().get(servicePath[homeRecommend]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("推荐消息请求异常");
    }
  } catch (e) {
    return print('推荐消息请求异常Error------------->$e');
  }
}

//请求分类消息
Future homeClassService() async {
  try {
    Response response = await BaseRequest().get(servicePath[homeClass]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("分类消息请求异常");
    }
  } catch (e) {
    return print('分类消息请求Error------------->$e');
  }
}

//请求关注消息
Future homeFollowService() async {
  try {
    Response response = await BaseRequest().get(servicePath[homeFollow]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("关注消息请求异常");
    }
  } catch (e) {
    return print('关注消息请求Error------------->$e');
  }
}

//请求收藏消息
Future myCollectService() async {
  try {
    Response response = await BaseRequest().get(servicePath[myCollect]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("收藏消息请求异常");
    }
  } catch (e) {
    return print('收藏消息请求Error------------->$e');
  }
}
