import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/provider/messageState.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';

List<TopComment> _comments;

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //显示标题栏目，主题内容，底部按钮
    return Scaffold(
      //“详情”标题
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "详情",
        ),
      ),
      //主题部分包含该消息内容，评论内容
      body: new Column(
        children: <Widget>[
          TextDetail(),
          SizedBox(
            height: 1.0,
          ),
          Expanded(
            child: InterAction(),
          ),
        ],
      ),
      //底部按钮
      bottomNavigationBar: BottomInter(),
    );
  }
}

//正文部分
class TextDetail extends StatefulWidget {
  @override
  _TextDetailState createState() => _TextDetailState();
}

class _TextDetailState extends State<TextDetail> {
  String _followIcon;

  @override
  Widget build(BuildContext context) {
    MessageData _message = ModalRoute.of(context).settings.arguments;
    if (_followIcon == null) {
      _followIcon = _message.isFollowed ? "已关注" : "关注";
    }
    //图片组件加载
    List<Widget> images = [];
    for (var image in _message.imgsName) {
      images.add(
        new Container(
          child: Image.network(
            Utils.imgPath(image),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 1.0),
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.grey, //阴影颜色
            blurRadius: 5.0, //阴影大小
          ),
        ],
        border: Border(
          top: BorderSide(color: Colors.white12, width: 1.0),
          bottom: BorderSide(color: Colors.white30, width: 1.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          //发布者信息
          new Row(
            children: <Widget>[
              //发布者头像
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  height: 70,
                  color: Colors.white,
                  child: Image(
                    image: new NetworkImage(
                      Utils.webImgPath(_message.avatar),
                    ),
                  ),
                ),
                flex: 1,
              ),
              //发布者昵称
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  height: 70.0,
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: new Text(
                    _message.name,
                    maxLines: 1,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                flex: 1,
              ),
              //关注按钮
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
                    child: Text(
                      _followIcon,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.deepOrange,
                        fontSize: 15.0,
                      ),
                    ),
                    //点击关注按钮的回调
                    onPressed: () async {
                      setState(() {
                        if (_followIcon == "已关注") {
                          _followIcon = "关注";
                        } else {
                          _followIcon = "已关注";
                        }
                      });
                      if (_followIcon == "已关注") {
                        final onValue =
                            await followService(_message.designerId);
                        if (onValue['status'] != 'success') {
                          _followIcon = "关注";
                        }
                      } else {
                        final onValue =
                            await cancelFollowService(_message.designerId);
                        if (onValue['status'] != 'success') {
                          _followIcon = "已关注";
                        }
                      }
                      Provider.of<MessageState>(context).updateFollow();
                      Provider.of<MessageState>(context).updateRecommend();
                      Provider.of<MessageState>(context).updateCollect();
                    },
                  ),
                ),
                flex: 3,
              ),
            ],
          ),
          //消息文本内容
          new Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(top: 10.0, left: 5.0),
            child: Text(
              _message.content != null ? _message.content : "无标题",
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
          //消息图片内容
          new Container(
            margin: const EdgeInsets.only(top: 15.0),
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: Wrap(
              spacing: 5.0,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: images.length != 0 ? images : Text("无图片"),
            ),
          ),
          new Container(
//            color: Color.fromARGB(125, 250, 250, 250),
            child: SizedBox(
              height: 20.0,
            ),
          ),
          //评论栏
          new Container(
            padding: const EdgeInsets.only(left: 5.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              "评论",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//互动栏目
class InterAction extends StatefulWidget {
  @override
  _InterActionState createState() => _InterActionState();
}

class _InterActionState extends State<InterAction> {
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

  //单条评论条目
  Widget _items(index) {
    return Material(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Material(
                child: ListTile(
                  title: Text("查看回复"),
                  leading: Icon(Icons.speaker_notes),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      "replys",
                      arguments: [
                        _comments[index],
                        _comments[index].secondComment,
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
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
    MessageData _message = ModalRoute.of(context).settings.arguments;
    _comments = _message.topComment;
    if (_comments.length == 0) {
      return Center(
        child: Text("暂无评论"),
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

//点赞收藏按钮
class BottomInter extends StatefulWidget {
  @override
  _BottomInterState createState() => _BottomInterState();
}

class _BottomInterState extends State<BottomInter> {
  MessageData _message;
  IconData _likeIcon;
  IconData _collectIcon;
  int _countLike;

  TextEditingController _text = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _text.addListener(() {
      print("评论的监听方法：" + _text.text);
    });
//    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
//    _focusNode.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _message = ModalRoute.of(context).settings.arguments;
    if (_likeIcon == null) {
      //初次构建页面赋值
      _likeIcon = _message.isLiked ? Icons.favorite : Icons.favorite_border;
      _collectIcon = _message.isCollected ? Icons.star : Icons.star_border;
      _countLike = _message.sumLikes;
    }
    return Container(
      width: double.infinity,
      height: 50.0,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: BorderSide(color: Colors.white10, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Material(
            color: Colors.white,
            child: new Row(
              children: <Widget>[
                new IconButton(
                  icon: Icon(_likeIcon),
                  color: Colors.red,
                  onPressed: () async {
                    setState(() {
                      if (_likeIcon == Icons.favorite) {
                        _likeIcon = Icons.favorite_border;
                        _countLike--;
                      } else {
                        _likeIcon = Icons.favorite;
                        _countLike++;
                      }
                    });
                    if (_likeIcon == Icons.favorite) {
                      final onValue = await likeService(_message.id);
                      if (onValue['status'] != 'success') {
                        _likeIcon = Icons.favorite_border;
                        _countLike--;
                      }
                    } else {
                      final onValue = await cancelLikeService(_message.id);
                      if (onValue['status'] != 'success') {
                        _likeIcon = Icons.favorite;
                        _countLike++;
                      }
                    }
                    Provider.of<MessageState>(context).updateCollect();
                    Provider.of<MessageState>(context).updateRecommend();
                    Provider.of<MessageState>(context).updateFollow();
//                    Provider.of<MessageState>(context).updateCategory(0);
                  },
                ),
                new Text(_countLike.toString()),
              ],
            ),
          ),
          Material(
            color: Colors.white,
            child: new IconButton(
              icon: Icon(_collectIcon),
              color: Colors.amber,
              iconSize: 30,
              onPressed: () async {
                setState(() {
                  if (_collectIcon == Icons.star) {
                    _collectIcon = Icons.star_border;
                  } else {
                    _collectIcon = Icons.star;
                  }
                });
                if (_collectIcon == Icons.star) {
                  final onValue = await collectService(_message.id);
                  if (onValue['status'] != 'success') {
                    _collectIcon = Icons.star_border;
                  }
                } else {
                  final onValue = await cancelCollectService(_message.id);
                  if (onValue['status'] != 'success') {
                    _collectIcon = Icons.star;
                  }
                }
                Provider.of<MessageState>(context).updateRecommend();
                Provider.of<MessageState>(context).updateCollect();
                Provider.of<MessageState>(context).updateFollow();
//                Provider.of<MessageState>(context).updateCategory(0);
              },
            ),
          ),
          Material(
            color: Colors.white,
            child: new IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.grey,
              ),
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Material(
                      child: TextField(
                        controller: _text,
                        decoration: InputDecoration(
                          hintText: "  输入想要说的话吧~",
                          suffixIcon: new IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              String _showText = '评论成功';
                              if (_text.text != '') {
                                TopComment _content = new TopComment(
                                  content: _text.text,
                                  createBy: "我",
                                  createAt: "刚刚",
                                );
                                _showText = '评论成功';
                                commentService(1, _message.id, _text.text)
                                    .then((onValue) {
                                  if (onValue['status'] == 'success') {
                                    Navigator.pop(context);
                                    setState(() {
                                      _comments.add(_content);
                                    });
                                    Provider.of<MessageState>(context)
                                        .updateRecommend();
                                    Provider.of<MessageState>(context)
                                        .updateCollect();
                                    Provider.of<MessageState>(context)
                                        .updateFollow();
                                  }
                                });
                              } else {
                                _showText = "评论内容不能为空";
                              }
                              final _snackBar = new SnackBar(
                                content: new Text(_showText),
                                backgroundColor: Colors.blue,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 1),
                              );
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
