import 'package:dio/dio.dart';
import 'package:furture/service/serviceUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'serviceUrl.dart';
import './baseRequest.dart';

//import 'dart:convert';
//
String token = 'token';

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
    var loginParam = {"username": username, "password": password};
    //获取请求
    Response response = await dio.post(servicePath[login], data: loginParam);
    if (response.statusCode == 200) {
      SharedPreferences saveToken = await SharedPreferences.getInstance();
      saveToken.setString(token, response.data['data']);
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
    Response response =
        await dio.get(servicePath[code], queryParameters: codeParam);
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
        await dio.post(servicePath[register], data: registerParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("注册请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

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

//用户信息请求
Future getUserService() async {
  try {
    //获取请求
    Response response = await dio.get(servicePath[user]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("用户信息请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//用户信息编辑
Future postUserService(String email, String sex, String nickname) async {
  try {
    var userParam = {'email': email, 'sex': sex, 'nickname': nickname};
    //获取请求
    Response response = await dio.post(servicePath[user], data: userParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("信息编辑请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//用户关注请求
Future followService(String id) async {
  try {
    var followParam = {
      'id': id,
    };
    //获取请求
    Response response = await dio.post(servicePath[follow], data: followParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("关注请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//用户取消关注请求
Future unfollowService(String id) async {
  try {
    var followParam = {
      'id': id,
    };
    //获取请求
    Response response =
        await dio.delete(servicePath[follow], data: followParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("取消关注请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//用户收藏请求
Future collectService(String id) async {
  try {
    var collectParam = {
      'id': id,
    };
    //获取请求
    Response response =
        await dio.post(servicePath[collect], data: collectParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("收藏请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//用户取消收藏请求
Future uncollectService(String id) async {
  try {
    var collectParam = {
      'id': id,
    };
    //获取请求
    Response response =
        await dio.delete(servicePath[collect], data: collectParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("取消收藏请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//用户点赞请求
Future likeService(String id) async {
  try {
    var likeParam = {
      'id': id,
    };
    //获取请求
    Response response = await dio.post(servicePath[like], data: likeParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("点赞请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//用户取消点赞请求
Future unlikeService(String id) async {
  try {
    var likeParam = {
      'id': id,
    };
    //获取请求
    Response response = await dio.delete(servicePath[like], data: likeParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("取消点赞请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//请求颜色列表
Future getColorService(String id) async {
  try {
    //获取请求
    Response response = await dio.get(servicePath[color]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("颜色请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//设置颜色请求
Future postColorService(int colorId) async {
  try {
    var colorIdParam = {
      'color_id': colorId,
    };
    //获取请求
    Response response = await dio.post(servicePath[color], data: colorIdParam);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("颜色设置请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//退出登录请求
Future logoutService() async {
  try {
    Response response = await dio.post(servicePath[logout]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("退出登录请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//请求推荐消息
Future homeRecommendService() async {
  try {
    Response response = await dio.get(servicePath[homeRecommend]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("推荐消息请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//请求分类消息
Future homeClassService() async {
  try {
    Response response = await dio.get(servicePath[homeClass]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("推荐消息请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//请求关注消息
Future homeFollowService() async {
  try {
    Response response = await dio.get(servicePath[homeFollow]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("推荐消息请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//请求收藏消息
Future myCollectService() async {
  try {
    Response response = await dio.get(servicePath[myCollect]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("推荐消息请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}
