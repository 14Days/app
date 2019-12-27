import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/page/PhotoView.dart';
import 'package:furture/provider/messageState.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';

List<TopComment> _comments;
MessageData _message;

//主体部分由三部分构成 正文 互动评论 点赞等按钮 （底部评论抽离出来形成一个组件）
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
      body: new CustomScrollView(
        physics: ScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: new Column(
              children: <Widget>[
                TextDetail(),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MyDelegate(
              child: new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 20.0),
                alignment: Alignment.topLeft,
                child: Text(
                  "评论",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          InterAction(),
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
  //关注按钮的文本状态改变
  String _followIcon;

  @override
  Widget build(BuildContext context) {
    //接收参数
    MessageData _message = ModalRoute.of(context).settings.arguments;
    if (_followIcon == null) {
      _followIcon = _message.isFollowed ? "已关注" : "关注";
    }
    //图片组件列表化组合
    List<Widget> images = [];
    List<Widget> noImage = [];
    for (var image in _message.imgsName) {
      images.add(
        new GestureDetector(
          child: Container(
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
    return Container(
      margin: const EdgeInsets.only(top: 1.0),
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 15.0,
        right: 15.0,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.grey, //阴影颜色
            blurRadius: 3.0, //阴影大小
          ),
        ],
        border: Border(
          top: BorderSide(color: Colors.white12, width: 1.0),
          bottom: BorderSide(color: Colors.white30, width: 1.0),
        ),
      ),
      /*列元素控制 / 顶部发布者 / 文本信息 / 评论区 / */
      child: Column(
        children: <Widget>[
          /*发布者信息*/
          new Row(
            children: <Widget>[
              //发布者头像
              Container(
                height: 60.0,
                width: 60.0,
                color: Colors.white,
                child: GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      right: 10,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        Utils.webImgPath(_message.avatar),
                      ),
                    ),
                  ),
                ),
              ),
              //发布者昵称
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
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
                      Provider.of<MessageState>(context).updateCategory(
                          Provider.of<MessageState>(context).classIndex + 44);
                    },
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
          /*消息文本内容*/
          new Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(top: 10.0, left: 5.0),
            child: Text(
              _message.content != null ? _message.content : " ",
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
          /*消息图片内容*/
          new Container(
            margin: const EdgeInsets.only(top: 15.0),
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: images.length != 0 ? images : noImage,
            ),
          ),
          new Container(
            child: SizedBox(
              height: 20.0,
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //单条评论条目
  Widget _items(index) {
    return Material(
      child: InkWell(
        onTap: () {
          //点击评论文本弹出回复框
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
        /* 评论内容 */
        child: Container(
          //定义外部框
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 10.0,
            bottom: 10.0,
          ),
          margin: const EdgeInsets.only(bottom: 6.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
//            boxShadow: <BoxShadow>[
//              new BoxShadow(
//                color: Colors.grey, //阴影颜色
//                offset: Offset(0, 1),
//                blurRadius: 3.0, //阴影大小
//              ),
//            ],
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
              right: BorderSide(width: 0.5, color: Colors.black12),
              bottom: BorderSide(width: 2, color: Colors.grey[300]),
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
                  maxLines: 1,
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

  /*评论的构建 listView 滚动组件*/
  @override
  Widget build(BuildContext context) {
    _message = ModalRoute.of(context).settings.arguments;
    _comments = _message.topComment;
    if (_comments.length == 0) {
      return SliverFillRemaining(
        child: Center(
          child: Text("暂无评论"),
        ),
      );
    } else {
      return SliverFixedExtentList(
        // SliverList的语法糖，用于每个item固定高度的List
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            child: _items(index),
          ),
          childCount: _comments.length,
        ),
        itemExtent: 100,
      );
//      return ListView.builder(
//        shrinkWrap: true,
//        physics: NeverScrollableScrollPhysics(),
//        scrollDirection: Axis.vertical,
//        itemCount: _comments.length,
//        itemBuilder: (context, index) {
//          return _items(index);
//        },
//      );
    }
  }
}

//点赞收藏按钮
class BottomInter extends StatefulWidget {
  @override
  _BottomInterState createState() => _BottomInterState();
}

class _BottomInterState extends State<BottomInter> {
//  MessageData _message;
  IconData _likeIcon;
  IconData _collectIcon;
  int _countLike;

  @override
  Widget build(BuildContext context) {
    _message = ModalRoute.of(context).settings.arguments;
    //初次构建页面赋值
    if (_likeIcon == null) {
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
            //点赞按钮
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
                    Provider.of<MessageState>(context).updateCategory(
                        Provider.of<MessageState>(context).classIndex + 44);
                  },
                ),
                new Text(_countLike.toString()),
              ],
            ),
          ),
          Material(
            //收藏按钮
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
                Provider.of<MessageState>(context).updateCategory(
                    Provider.of<MessageState>(context).classIndex + 44);
              },
            ),
          ),
          Material(
            //评论按钮
            color: Colors.white,
            child: new IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PopRoute(
                    child: BottomInput(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

//底部评论弹出框
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
    _message = ModalRoute.of(context).settings.arguments;
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
            height: 70,
            color: Colors.white,
            child: TextField(
              autofocus: true,
              maxLength: 50,
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
                      TopComment _content = new TopComment(
                        content: _text.text,
                        createBy: "我",
                        createAt: "刚刚",
                      );
                      final onValue =
                          await commentService(1, _message.id, _text.text);
                      if (onValue['status'] == 'success') {
                        Navigator.pop(context);
                        setState(() {
                          _comments.add(_content);
                        });
                        Provider.of<MessageState>(context).updateRecommend();
                        Provider.of<MessageState>(context).updateCollect();
                        Provider.of<MessageState>(context).updateFollow();
                        Provider.of<MessageState>(context).updateCategory(
                            Provider.of<MessageState>(context).classIndex + 44);
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

class MyDelegate extends SliverPersistentHeaderDelegate {
  final Container child;

  MyDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => 20;

  @override
  double get minExtent => 20;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
