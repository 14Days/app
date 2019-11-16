import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import './setPage.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  List<Widget> list = List();

  @override
  void initState() {
    list..add(HomePage())..add(NoticePage())..add(MyPage());
    super.initState(); //无名无参需要调用
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 25.0),
                height: 125.0,
                color: Colors.blue,
//                child: new Image(image: "111"),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 25.0),
                height: 125.0,
                alignment: Alignment.centerLeft,
                color: Colors.blue,
                child: new Text(
                  "11111111",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    textBaseline: null,
                  ),
                ),
              ),
              flex: 3,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 25.0),
                height: 125.0,
                color: Colors.blue,
                child: Material(
                  color: Colors.blue,
                  child: new IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () {
//                      Navigator.of(context).push(
//                        MaterialPageRoute(builder: (context) => SetPage()),
//                      );
                      Application.router.navigateTo(context, Routes.set);
                    },
                  ),
                ),
              ),
              flex: 1,
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            Expanded(
                child: Container(
              height: 50.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(width: 1.0, color: Colors.grey),
              ),
              child: Text(
                "我的收藏",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27.0,
                  color: Colors.black,
                ),
              ),
            )),
          ],
        ),
        new Expanded(
          child: CollectItem(),
        )
      ],
    );
  }
}

//类
class CollectItem extends StatelessWidget {
//  final String item;
//
//  CollectItem({Key key, this.item}) : super(key: key);
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

  //定义单条收藏栏目
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
//            new Image.network(recommend[index]['img']),
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
