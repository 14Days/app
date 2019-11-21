import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import '../service/serviceMethod.dart';

class NoticeState with ChangeNotifier {
  List<NoticeData> _items = [];

  List<NoticeData> get items => _items;

  updateNotice() async {
    NoticeModel noticeModel;
    final onValue = await noticeService();
    if (onValue['status'] == 'success') {
      noticeModel = NoticeModel.fromJson(onValue);
    }
    _items = noticeModel.data;
    notifyListeners();
  }
}
