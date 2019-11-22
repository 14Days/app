import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class HomeClass extends StatefulWidget {
  @override
  _HomeClassState createState() => _HomeClassState();
}

class _HomeClassState extends State<HomeClass>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState(); //无名无参需要调用
  }

  @override
  void dispose() {
    super.dispose();
  }

  //基本框架 顶部分类+分类内容
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TopClass(),
        ),
        Expanded(
          flex: 10,
          child: CategoryBody(),
        ),
      ],
    );
  }
}

//顶部分类栏
class TopClass extends StatefulWidget {
  @override
  _TopClassState createState() => _TopClassState();
}

class _TopClassState extends State<TopClass> {
  List category = [
    '优美典雅',
    '古典幽默',
    "电压陈宇",
    '是的是的',
    '斯蒂法国',
    '刚刚的啊',
    ' 发生的啊',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
          return _singleClass(index);
        },
      ),
    );
  }

  //单类别组件
  Widget _singleClass(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 100.0,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.black12),
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Text(
          category[index],
          maxLines: 1,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}

//分类内容
// ignore: must_be_immutable
class CategoryBody extends StatelessWidget {
  final List<Map<String, dynamic>> category = [
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

  //定义单条消息
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
              category[index]['text'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
//            new Image.network(category[index]['img']),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: category.length,
      itemBuilder: (context, index) {
        return Material(
          child: _item(index),
        );
      },
    );
  }
}
