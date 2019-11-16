import 'package:flutter/material.dart';
import 'package:furture/model/entity.dart';

class Category with ChangeNotifier {
  List<RecommendModel> recommendList = [];

//  int get value => _count;

  void increment(List list) {
    recommendList = list;
    notifyListeners();
  }
}
