import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';

import '../service/serviceMethod.dart';

class MessageState with ChangeNotifier {
  int _classIndex = 0;
  List<MessageData> _recommend = [];
  List<MessageData> _follow = [];
  List<MessageData> _category = [];
  List<MessageData> _collect = [];

  List<MessageData> get recommend => _recommend;

  List<MessageData> get follow => _follow;

  List<MessageData> get category => _category;

  List<MessageData> get collect => _collect;

  int get classIndex => _classIndex;

  updateRecommend() async {
    MessageModel recommendModel;
    final onValue = await homeRecommendService();
    if (onValue['status'] == 'success') {
      recommendModel = MessageModel.fromJson(onValue);
    }
    if (recommendModel == null) {
      _recommend.clear();
    } else {
      _recommend = recommendModel.data;
    }

    notifyListeners();
  }

  updateFollow() async {
    MessageModel followModel;
    final onValue = await homeFollowService();
    if (onValue['status'] == 'success') {
      followModel = MessageModel.fromJson(onValue);
    }
    if (followModel == null) {
      _follow.clear();
    } else {
      _follow = followModel.data;
    }

    notifyListeners();
  }

  updateCollect() async {
    MessageModel collectModel;
    final onValue = await myCollectService();
    if (onValue['status'] == 'success') {
      collectModel = MessageModel.fromJson(onValue);
    }
    if (collectModel == null) {
      _collect.clear();
    } else {
      _collect = collectModel.data;
    }

    notifyListeners();
  }

  updateCategory(int index) async {
    MessageModel categoryModel;
    final onValue = await homeClassService(index);
    if (onValue['status'] == 'success') {
      categoryModel = MessageModel.fromJson(onValue);
    }
    if (categoryModel == null) {
      _category.clear();
    } else {
      _category = categoryModel.data;
    }

    notifyListeners();
  }
  updateIndex(int index) async {
    _classIndex = index;
    notifyListeners();
  }
}
