import 'package:flutter/material.dart';

class Utils {
  static String myImgPath(String name) {
    return 'http://pull.wghtstudio.cn/avatar/app/$name';
  }

  static String webImgPath(String name) {
    return 'http://pull.wghtstudio.cn/avatar/web/$name';
  }

  static String imgPath(String name) {
    return 'http://pull.wghtstudio.cn/img/$name';
  }
}

///间隔
class Gaps {
  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: 5.0);
  static Widget vGap10 = new SizedBox(height: 10.0);
  static Widget vGap15 = new SizedBox(height: 15.0);

  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: 5.0);
  static Widget hGap10 = new SizedBox(width: 10.0);
  static Widget hGap15 = new SizedBox(width: 15.0);
}
