import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import './setPage.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
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
    return new Column(
      children: <Widget>[
        TextDetails(),
//        Interaction(),
        BottomInter(),
      ],
    );
  }
}

//正文部分
class TextDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          //发布者信息
          new Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  height: 70,
                  color: Colors.white,
//                child: new Image(image: "111"),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  height: 70.0,
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: new Text(
                    "11111111",
                    maxLines: 1,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0,
                      color: Colors.deepOrange,
                      textBaseline: null,
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: new Container(
                    width: 50.0,
                    height: 40.0,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.deepOrange),
                      ),
                      color: Colors.white,
//                      focusColor: Colors.white,
//                      highlightColor: Colors.blue[700],
//                      colorBrightness: Brightness.dark,
//                      splashColor: Colors.white,
                      child: Text(
                        "关注",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.deepOrange,
                          fontSize: 15.0,
                        ),
                      ),
                      onPressed: () {},
                    )),
                flex: 3,
              ),
            ],
          ),
          new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Text(
              "地方回房间节哀吧就发就好哈嘎嘎阿济格哈卡结果卡吉尔啊哈二号哈哈酒啊后就会教大家啊",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
          new Container(
            color: Colors.white,
//            child: Image.network('1111'),
          )
        ],
      ),
    );
  }
}

//互动栏目
class Interaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}

//点赞收藏按钮
class BottomInter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 0),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Material(
              child: new Row(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.thumb_up), onPressed: null),
              new Text("12"),
            ],
          )),
          Material(
              child: new IconButton(
                  icon: Icon(Icons.star_border), onPressed: null)),
          Material(
              child: new IconButton(icon: Icon(Icons.message), onPressed: null))
        ],
      ),
    );
  }
}
