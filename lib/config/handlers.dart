import 'package:furture/component/comment.dart';
import '../page/findPassword.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

var registerHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new RegisterPage();
});

var findpwdHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new FindpwdPage();
});

var btmNaHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new BottomNavigation();
    });

var noticeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new NoticePage();
    });

var myHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new MyPage();
    });

