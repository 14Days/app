import 'package:flutter/material.dart';

class User {
  String username;
  String password;
  String img;
  String phone;
  String color;
  String email;
  int sex;

  User(this.username, this.password, this.img, this.phone, this.color,
      this.email, this.sex);

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        img = json['img'],
        phone = json['phone'],
        color = json['color'],
        email = json['email'],
        sex = json['sex'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'username': username,
        'password': password,
        'img': img,
        'phone': phone,
        'color': color,
        'email': email,
        'sex': sex
      };
//  @override
//  String toString() {
//    StringBuffer sb = new StringBuffer('{');
//    sb.write("\"titleId\":\"$titleId\"");
//    sb.write(",\"languageCode\":\"$languageCode\"");
//    sb.write(",\"countryCode\":\"$countryCode\"");
//    sb.write('}');
//    return sb.toString();
//  }
}

List<Widget> topTabs = [
  new Tab(
    child: Text(
      "推荐",
      style: new TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    ),
  ),
  new Tab(
    child: Text(
      "关注",
      style: new TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    ),
  ),
  new Tab(
    child: Text(
      "分类",
      style: new TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    ),
  ),
];
