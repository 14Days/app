import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import '../service/serviceMethod.dart';

class UserState with ChangeNotifier {
  String _nickname = '';
  int _sex = 1;
  String _email = '';
//  String _avatar = '';
  int _color = 1;

  String get nickname => _nickname;

  int get sex => _sex;

  String get email => _email;

//  String get avatar => _avatar;
//List<int>
  int get color => _color;

  setNickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }

  setSex(int sex) {
    _sex = sex;
    notifyListeners();
  }

  setEmail(String email) {
    _nickname = nickname;
    notifyListeners();
  }

  setColor(int color) {
    _color = color;
    notifyListeners();
  }

//  setAvatar(String avatar) {
//    _avatar = avatar;
//    notifyListeners();
//  }

  getUserInfo() async {
    UserModel userModel;
    final onValue = await getUserService();
    if (onValue['status'] == 'success') {
      userModel = UserModel.fromJson(onValue);
    }
    _nickname = userModel.data.nickname;
    _sex = userModel.data.sex;
    _email = userModel.data.email;
    _color = userModel.data.color;
  }
}
