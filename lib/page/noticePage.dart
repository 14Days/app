import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/service/serviceMethod.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "通知",
        ),
      ),
      body: new Container(
        child: NoticeBody(),
      ),
    );
  }
}

//通知类
// ignore: must_be_immutable

class NoticeBody extends StatefulWidget {
  @override
  _NoticeBodyState createState() => _NoticeBodyState();
}

class _NoticeBodyState extends State<NoticeBody> {
  NoticeModel noticeItems;

  void getNotice() async {
    final onValue = await noticeService();
    setState(() {
      if (onValue['status'] == 'success') {
        noticeItems = NoticeModel.fromJson(onValue);
      }
    });
  }

  @override
  void initState() {
//    getNotice();
    super.initState();

  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  //定义通知消息
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
              right: BorderSide(width: 0.5, color: Colors.black12),
              top: BorderSide(width: 0.5, color: Colors.black12),
              bottom: BorderSide(width: 0.5, color: Colors.black12),
            )),
        child: Column(
          children: <Widget>[
            new Text(
              noticeItems.data[index].content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            new Text(noticeItems.data[index].createAt),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getNotice();
    if (noticeItems == null) {
      return Center(
        child: Text(
          "暂无通知",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    } else {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: noticeItems.data.length,
          itemBuilder: (context, index) {
            return Material(child: _item(index));
          });
    }
  }
}
