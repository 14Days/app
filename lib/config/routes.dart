import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'handlers.dart';

class Routes {
  static Router router;
  static String root = "/";
  static String login = "/login";
  static String register = "/register";
  static String findPassword = "/findPassword";
  static String bottomNavigator = "/btmNavigator";
  static String notice = "/notice";
  static String my = "/my";
  static String homeRecommend = "/home/recommend";
  static String homeFollow = "/home/follow";
  static String homeClass = "home/class";

  static void configureRoutes(Router router) {
    //跳转至登录
    router.define(
        login, handler: loginHandler);
    //跳转至注册
    router.define(
        register, handler: registerHandler);
    //跳转至找回密码
    router.define(
        findPassword, handler: findpwdHandler);
    //跳转至首页
    router.define(
        bottomNavigator, handler: btmNaHandler);
    //跳转至通知
    router.define(
        notice, handler: noticeHandler);
    //跳转至我的
    router.define(
        my, handler: myHandler);
    //跳转至首页推荐
    router.define(
        homeRecommend, handler: loginHandler);
    //跳转至首页关注
    router.define(
        homeFollow, handler: registerHandler);
    //跳转至首页分类
    router.define(
        homeClass, handler: findpwdHandler);
  }
}