import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/provider/messageState.dart';
import '../provider/userState.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<UserState>(context).getUserInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        TopMessage(),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 50.0,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(width: 1.0, color: Colors.grey),
                ),
                child: Text(
                  "我的收藏",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: CollectItem(),
        )
      ],
    );
  }
}

class TopMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    return Container(
      child: new Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 25.0),
              height: 125.0,
              color: Colors.blue,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 30, right: 30, top: 15, bottom: 15),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white70,
                  backgroundImage: NetworkImage(Utils.myImgPath(user.avatar)),
                ),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 25.0),
              height: 125.0,
              alignment: Alignment.centerLeft,
              color: Colors.blue,
              child: Text(
                user.nickname,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 23.0,
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
                    Application.router.navigateTo(context, Routes.set);
                  },
                ),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class CollectItem extends StatefulWidget {
  @override
  _CollectItemState createState() => _CollectItemState();
}

class _CollectItemState extends State<CollectItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<MessageState>(context).updateCollect();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return CollectBody();
  }
}

//收藏
// ignore: must_be_immutable
class CollectBody extends StatefulWidget {
  @override
  _CollectBodyState createState() => _CollectBodyState();
}

class _CollectBodyState extends State<CollectBody> {
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
    for (var image in _message.collect[index].imgsName) {
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

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          "details",
          arguments: _message.recommend[index],
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
                _message.collect[index].content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border(
                  left: BorderSide(width: 0.5, color: Colors.black12),
                  right: BorderSide(width: 0.5, color: Colors.black12),
                  top: BorderSide(width: 0.5, color: Colors.black12),
                  bottom: BorderSide(width: 0.5, color: Colors.black12),
                ),
              ),
              child: Row(
                children: images,
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
    if (_message.collect.length == 0) {
      return Center(
        child: Text("你还没有收藏哦~"),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _message.collect.length,
        itemBuilder: (context, index) {
          return Material(
            child: _items(index),
          );
        },
      );
    }
  }
}
