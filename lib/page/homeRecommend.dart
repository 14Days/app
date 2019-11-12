import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/service/serviceMethod.dart';

class HomeRecommend extends StatefulWidget {
  @override
  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState(); //无名无参需要调用
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Recommend(),
    );
  }

//  @override
//  // ignore: must_cal_super
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//      future: loginService("zjg", "123456"),
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          Map userData = json.decode(snapshot.data.toString());
//          User user = User.fromJson(userData);
//          List<Map> recommend = (userData['data']['recommend'] as List).cast();
//          return Column(
//            children: <Widget>[Recommend(recommend: recommend)],
//          );
//        } else {
//          return Center(
//            child: Text("gg"),
//          );
//        }
//      },
//    );
//  }
}

//推荐类
// ignore: must_be_immutable
class Recommend extends StatelessWidget {
  List<Map<String, dynamic>> recommend = [
    {'img': '111', 'text': '222'},
    {'img': '111', 'text': '333'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
    {'img': '111', 'text': '444'},
  ];

//  Recommend({Key key, this.recommend}) : super(key: key);
//
  //定义单条推荐消息
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
              recommend[index]['text'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            new Image.network(recommend[index]['img']),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: recommend.length,
        itemBuilder: (context, index) {
          return Material(child: _item(index));
        });
  }
}
