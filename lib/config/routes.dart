import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'handlers.dart';

class Routes {
  static Router router;
  static String root = "/";
  static String login = "/login";
  static String register = "/register";
  static String bottomNavigator = "/btmNavigator";
  static String my = "/my";
  static String set = "/my/set";
  static String setSex = "/my/set/sex";
  static String setEmail = "/my/set/email";
  static String setColor = "/my/set/color";
  static String setNickname = "/my/set/nickname";
  static String setAvatar = "/my/set/avatar";
  static String setPassword = "/my/set/password";
  static String detail = "/detail";

  static void configureRoutes(Router router) {
    //跳转至登录
    router.define(login, handler: loginHandler);
    //跳转至注册
    router.define(register, handler: registerHandler);
    //跳转至首页
    router.define(bottomNavigator, handler: btmNaHandler);
    //跳转至我的
    router.define(my, handler: myHandler);
    //跳转至我的/设置
    router.define(set, handler: setHandler);
    //跳转至我的/设置/性别
    router.define(setSex, handler: setSexHandler);
    //跳转至我的/设置/邮件
    router.define(setEmail, handler: setEmailHandler);
    //跳转至我的/设置/颜色
    router.define(setColor, handler: setColorHandler);
    //跳转至我的/设置/昵称
    router.define(setNickname, handler: setNicknameHandler);
    //跳转至我的/设置/性别
    router.define(setAvatar, handler: setAvatarHandler);
    //跳转至我的/设置/密码
    router.define(setPassword, handler: setPasswordHandler);
    //跳转至详情
    router.define(detail, handler: detailHandler);
  }
}

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(opacity: animation, child: child),
        );
}
