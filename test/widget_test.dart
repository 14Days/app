// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:furture/model/entity.dart';

void main() async {
  ColorModel colors;
  final log = await loginService("wjq", "Zzzz1111");
  final onValue = await getColorService();
  print(onValue);
  if (onValue['status'] == 'success') {
    colors = ColorModel.fromJson(onValue);
    print(colors);
  }
}
