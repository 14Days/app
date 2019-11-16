import 'package:flutter/material.dart';

class UserModel {
  String username;
  String password;
  String img;
  String phone;
  String color;
  String email;
  int sex;

  UserModel(this.username, this.password, this.img, this.phone, this.color,
      this.email, this.sex);

  UserModel.fromJson(Map<String, dynamic> json)
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
}

class RecommendModel {
  String name;
  String avatar;
  String create_at;
  List<String> img_url;
  int sum_likes;
  int sum_comments;
  String content;
  String id;
  String designer_id;
  bool id_follow;

  RecommendModel(
      this.name,
      this.avatar,
      this.create_at,
      this.img_url,
      this.sum_likes,
      this.sum_comments,
      this.content,
      this.id,
      this.designer_id,
      this.id_follow);

  RecommendModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        avatar = json['avatar'],
        img_url = json['img_url'],
        sum_likes = json['sum_likes'],
        sum_comments = json['sum_comments'],
        content = json['content'],
        id = json['id'],
        designer_id = json['designer_id'],
        id_follow = json['id_follow'];
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'avatar': avatar,
    'img_url': img_url,
    'sum_likes': sum_likes,
    'sum_comments': sum_comments,
    'content': content,
    'id': id,
    'designer_id': designer_id,
    'id_follow': id_follow,
  };
}


//通知类 Model & Data
class NoticeModel {
  List<NoticeData> data;
  String status;
  NoticeModel({this.data, this.status});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<NoticeData>();
      json['data'].forEach((v) {
        data.add(new NoticeData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
class NoticeData {
  String content;
  String createAt;

  NoticeData({this.content, this.createAt});

  NoticeData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['create_at'] = this.createAt;
    return data;
  }
}


//颜色类 Model & Data
class ColorModel {
  List<ColorData> data;

  ColorModel({this.data});

  ColorModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ColorData>();
      json['data'].forEach((v) {
        data.add(new ColorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ColorData {
  String color;
  int colorId;

  ColorData({this.color, this.colorId});

  ColorData.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    colorId = json['color_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['color_id'] = this.colorId;
    return data;
  }
}
