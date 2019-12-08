import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/provider/messageState.dart';
import 'package:furture/provider/userState.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:provider/provider.dart';

List _message;
TopComment _topComment;
List<SecondComment> _comments;

class SecondCommentPage extends StatefulWidget {
  @override
  _SecondCommentPageState createState() => _SecondCommentPageState();
}

class _SecondCommentPageState extends State<SecondCommentPage> {
  @override
  Widget build(BuildContext context) {
    //显示标题栏目，主题内容，底部按钮
    return Scaffold(
      //“详情”标题
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "回复",
        ),
      ),

      body: new Column(
        children: <Widget>[
          MainPost(),
          Container(
            padding: const EdgeInsets.only(left: 25.0, top: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "他的回复",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: ReplyAction(),
          ),
        ],
      ),
    );
  }
}

//主帖内容显示
class MainPost extends StatefulWidget {
  @override
  _MainPostState createState() => _MainPostState();
}

class _MainPostState extends State<MainPost> {
  TextEditingController _text = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _text.addListener(() {
      print("评论的监听方法：" + _text.text);
    });
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _message = ModalRoute.of(context).settings.arguments;
    _topComment = _message[0];

    return Material(
      child: InkWell(
        onTap: () {
          if (Provider.of<UserState>(context).nickname !=
                  _topComment.createBy &&
              _topComment.createBy != '我') {
            Navigator.push(
              context,
              PopRoute(
                child: BottomInput(),
              ),
            );
          }
        },
        child: Container(
          //定义外部框
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
          margin: const EdgeInsets.only(bottom: 5.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
              right: BorderSide(width: 0.5, color: Colors.black12),
              bottom: BorderSide(width: 0.5, color: Colors.black38),
            ),
          ),
          child: Column(
            children: <Widget>[
              //评论者
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  _topComment.createBy != null ? _topComment.createBy : "无名",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
              ),
              //评论时间
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  _topComment.createAt != null ? _topComment.createAt : "刚刚",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              //评论内容
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  _topComment.content != null ? _topComment.content : "刚刚",
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//回复栏目
class ReplyAction extends StatefulWidget {
  @override
  _ReplyActionState createState() => _ReplyActionState();
}

class _ReplyActionState extends State<ReplyAction> {
  TextEditingController _text = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _text.addListener(() {
      print("评论的监听方法：" + _text.text);
    });
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  //单条回复条目
  Widget _items(index) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          //定义外部框
          padding: const EdgeInsets.only(
              left: 30.0, right: 15.0, top: 10.0, bottom: 10.0),
          margin: const EdgeInsets.only(bottom: 5.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
              right: BorderSide(width: 0.5, color: Colors.black12),
              bottom: BorderSide(width: 0.5, color: Colors.black38),
            ),
          ),
          child: Column(
            children: <Widget>[
              //评论者
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  _comments[index].createBy != null
                      ? _comments[index].createBy
                      : "无名",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
              ),
              //评论时间
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  _comments[index].createAt != null
                      ? _comments[index].createAt
                      : "刚刚",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              //评论内容
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  _comments[index].content != null
                      ? _comments[index].content
                      : "刚刚",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _message = ModalRoute.of(context).settings.arguments;
    _comments = _message[1];
    if (_comments == null || _comments.length == 0) {
      return Center(
        child: Text("暂无回复"),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _comments.length,
        itemBuilder: (context, index) {
          return _items(index);
        },
      );
    }
  }
}

//底部评论文本弹出框
class BottomInput extends StatefulWidget {
  @override
  _BottomInputState createState() => _BottomInputState();
}

class _BottomInputState extends State<BottomInput> {
  TextEditingController _text = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _text.addListener(() {
      print("评论的监听方法：" + _text.text);
    });
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Column(
        children: <Widget>[
          Expanded(
            child: new GestureDetector(
              child: new Container(
                color: Colors.black54,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          new Container(
            height: 50,
            color: Colors.white,
            child: TextField(
              autofocus: true,
              maxLines: 100,
              controller: _text,
              decoration: InputDecoration(
                hintText: "  输入想要说的话吧~",
                suffixIcon: new IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    if (_text.text != '') {
                      SecondComment _content = new SecondComment(
                        content: _text.text,
                        createBy: "我",
                        createAt: "刚刚",
                      );
                      final onValue =
                          await commentService(2, _topComment.id, _text.text);
                      if (onValue['status'] == 'success') {
                        Navigator.pop(context);
                        setState(() {
                          _comments.add(_content);
                        });
                        Provider.of<MessageState>(context).updateRecommend();
                        Provider.of<MessageState>(context).updateCollect();
                        Provider.of<MessageState>(context).updateFollow();
                      }
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
