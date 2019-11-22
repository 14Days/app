import 'package:dio/dio.dart';
import 'package:furture/service/serviceUrl.dart';
import 'dart:async';
import 'serviceUrl.dart';
import './baseRequest.dart';

//用户信息请求
Future getUserService() async {
  try {
    //获取请求
    Response response = await BaseRequest().get(servicePath[user]);
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
Future postUserService(String email, int sex, String nickname) async {
  try {
    var userParam = {'email': email, 'sex': sex, 'nickname': nickname};
    //获取请求
    Response response =
        await BaseRequest().post(servicePath[user], data: userParam);
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
Future followService( id) async {
  try {
    var followParam = {
      'id': id,
    };
    //获取请求
    Response response =
        await BaseRequest().post(servicePath[follow], data: followParam);
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
Future cancelFollowService(int id) async {
  try {
    var followParam = {
      'id': id,
    };
    //获取请求
    Response response = await BaseRequest()
        .delete(servicePath[follow], queryParameters: followParam);
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
Future collectService(int id) async {
  try {
    var collectParam = {
      'id': id,
    };
    //获取请求
    Response response =
        await BaseRequest().post(servicePath[collect], data: collectParam);
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
Future cancelCollectService(int id) async {
  try {
    var collectParam = {
      'id': id,
    };
    //获取请求
    Response response = await BaseRequest()
        .delete(servicePath[collect], queryParameters: collectParam);
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
Future likeService(int id) async {
  try {
    var likeParam = {
      'id': id,
    };
    //获取请求
    Response response =
        await BaseRequest().post(servicePath[like], data: likeParam);
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
Future cancelLikeService(int id) async {
  try {
    var likeParam = {
      'id': id,
    };
    //获取请求
    Response response = await BaseRequest()
        .delete(servicePath[like], queryParameters: likeParam);
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
Future getColorService() async {
  try {
    //获取请求
    Response response = await BaseRequest().get(servicePath[color]);
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
    Response response =
        await BaseRequest().post(servicePath[color], data: colorIdParam);
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
    Response response = await BaseRequest().post(servicePath[logout]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("退出登录请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}

//设置头像请求
Future setAvatarService(FormData image) async {
  try {
    Response response =
        await BaseRequest().post(servicePath[setAvatar], data: image);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("退出登录请求异常");
    }
  } catch (e) {
    return print('Error------------->$e');
  }
}
