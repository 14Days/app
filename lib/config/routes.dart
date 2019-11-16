import 'package:fluro/fluro.dart';
import 'handlers.dart';

class Routes {
  static Router router;
  static String root = "/";
  static String login = "/login";
  static String register = "/register";
  static String bottomNavigator = "/btmNavigator";
  static String notice = "/notice";
  static String my = "/my";
  static String homeRecommend = "/home/recommend";
  static String homeFollow = "/home/follow";
  static String homeClass = "home/class";
  static String set = "my/set";

  static void configureRoutes(Router router) {
    //跳转至登录
    router.define(login, handler: loginHandler);
    //跳转至注册
    router.define(register, handler: registerHandler);
    //跳转至首页
    router.define(bottomNavigator, handler: btmNaHandler);
    //跳转至通知
    router.define(notice, handler: noticeHandler);
    //跳转至我的
    router.define(my, handler: myHandler);
    //跳转至首页/推荐
    router.define(homeRecommend, handler: loginHandler);
    //跳转至首页/关注
    router.define(homeFollow, handler: registerHandler);
    //跳转至首页/分类

    //跳转至我的/设置
    router.define(set, handler: setHandler);
  }
}
