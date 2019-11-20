import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import '../service/serviceMethod.dart';

class UserState with ChangeNotifier {
  String _nickname = '';
  int _sex = 0;
  String _email = '';
  String _avatar = '';
  int _color = 0;
  String _name = '';
  String _phone = '';

  String get nickname => _nickname;

  int get sex => _sex;

  String get email => _email;

  String get avatar => _avatar;

//List<int>
  int get color => _color;

  String get name => _name;

  String get phone => _phone;

  setNickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }

  setSex(int sex) {
    _sex = sex;
    notifyListeners();
  }

  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  setColor(int color) {
    _color = color;
    notifyListeners();
  }

  setAvatar(String avatar) {
    _avatar = avatar;
    notifyListeners();
  }

  getUserInfo() async {
    UserData userData;
    final onValue = await getUserService();
    if (onValue['status'] == 'success') {
      userData = UserData.fromJson(onValue['data']);
    }
    _nickname = userData.nickname;
    _sex = userData.sex;
    _email = userData.email;
    _color = userData.color;
    _name = userData.name;
    _phone = userData.phone;
    _avatar = userData.avatar;
    notifyListeners();
  }
}
