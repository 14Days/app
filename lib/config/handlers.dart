import 'package:furture/component/comment.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:furture/page/detailsPage.dart';

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


var btmNaHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new BottomNavigation();
    });


var myHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new MyPage();
    });

var setHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SetPage();
    });
var setSexHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SetSex();
    });
var setColorHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SetColor();
    });
var setEmailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SetEmail();
    });
var setNicknameHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SetNickname();
    });
var setAvatarHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SetAvatar();
    });
var detailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new DetailsPage();
    });


