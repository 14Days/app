import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/page/detailsPage.dart';

var rootHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new LoginPage();
  },
);

//跳转登录页面handler
var loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new LoginPage();
  },
);

//跳转注册
var registerHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new RegisterPage();
  },
);

//跳转底部导航
var btmNaHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new BottomNavigation();
  },
);
//跳转我的页
var myHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new MyPage();
  },
);


//跳转设置页
var setHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SetPage();
  },
);

//跳转设置性别
var setSexHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SetSex();
  },
);

//跳转设置颜色
var setColorHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SetColor();
  },
);

//跳转设置邮箱
var setEmailHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SetEmail();
  },
);

//跳转设置昵称
var setNicknameHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SetNickname();
  },
);

//跳转设置头像
var setAvatarHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SetAvatar();
  },
);
//跳转修改密码
var setPasswordHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SetPassword();
  },
);

//跳转详情
var detailHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new DetailsPage();
  },
);
