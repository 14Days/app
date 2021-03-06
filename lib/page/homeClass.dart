import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furture/config/routes.dart';
import 'package:furture/provider/messageState.dart';
import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';

import 'PhotoView.dart';
List category = [
  '动感',
  '自然',
  '清爽',
  '雅致',
  '豪华',
  '浪漫',
  '高贵',
  '冷休闲',
  '考究',
  '温暖',
];
Map<String, int> categoryIndex = {
  '动感': 44,
  '自然': 45,
  '清爽': 46,
  '雅致': 47,
  '豪华': 48,
  '浪漫': 49,
  '高贵': 50,
  '冷休闲': 51,
  '考究': 52,
  '温暖': 53,
};
int index;
class HomeClass extends StatefulWidget {
  @override
  _HomeClassState createState() => _HomeClassState();
}

class _HomeClassState extends State<HomeClass>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      index = Provider.of<MessageState>(context).classIndex;
      Provider.of<MessageState>(context).updateCategory(categoryIndex[category[index]]);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  //基本框架 顶部分类+分类内容
  @override
  Widget build(BuildContext context) {
    index = Provider.of<MessageState>(context).classIndex;
    return new Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TopClass(),
        ),
        Expanded(
          flex: 9,
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



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      index = Provider.of<MessageState>(context).classIndex;
      Provider.of<MessageState>(context).updateCategory(categoryIndex[category[index]]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (BuildContext context, int position) {
          return _singleClass(position);
        },
      ),
    );
  }

  //单类别组件
  Widget _singleClass(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Provider.of<MessageState>(context)
              .updateCategory(categoryIndex[category[i]]);
          index = i;
          Provider.of<MessageState>(context)
              .updateIndex(i);
        });
      },
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
          category[i],
          maxLines: 1,
          style: TextStyle(
            fontSize: index == i ? 17.0 : 15.0,
            color: index == i ? MyColors.colorOrange : MyColors.colorBlack,
          ),
        ),
      ),
    );
  }
}

//分类内容
// ignore: must_be_immutable

class CategoryBody extends StatefulWidget {
  @override
  _CategoryBodyState createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _items(index) {
    final _message = Provider.of<MessageState>(context);
    List<Widget> images = [];
    List<Widget> noImage = [];
    for (var image in _message.category[index].imgsName) {
      images.add(
        new GestureDetector(
          child: new Container(
            child: Image.network(
              Utils.imgPath(image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              new FadeRoute(
                page: PhotoViewPage(
                  imageProvider: NetworkImage(Utils.imgPath(image)),
                  maxScale: 2.0,
                  minScale: 0.5,
                ),
              ),
            );
          },
        ),
      );
    }
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          "details",
          arguments: _message.category[index],
        );
      },
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
          ),
        ),
        child: Column(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                _message.category[index].content != null
                    ? _message.category[index].content
                    : "无标题",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: images.length != 0 ? images : noImage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _message = Provider.of<MessageState>(context);
    if (_message.category.length == 0) {
      return Center(
        child: Text("暂无分类消息"),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _message.category.length,
        itemBuilder: (context, index) {
          return Material(
            child: _items(index),
          );
        },
      );
    }
  }
}
