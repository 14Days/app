import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/provider/messageState.dart';
import 'package:provider/provider.dart';
import 'package:furture/utils/utils.dart';

class HomeFollow extends StatefulWidget {
  @override
  _HomeFollowState createState() => _HomeFollowState();
}

class _HomeFollowState extends State<HomeFollow>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return FollowBody();
  }
}

//推荐类
// ignore: must_be_immutable
class FollowBody extends StatefulWidget {
  @override
  _FollowBodyState createState() => _FollowBodyState();
}

class _FollowBodyState extends State<FollowBody> {
  List<MessageData> _follow = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<MessageState>(context).updateFollow();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _items(index) {
    _follow = Provider.of<MessageState>(context).follow;
    List<Widget> images = [];
    List<Widget> noImage = [];
    for (var image in _follow[index].imgsName) {
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
    noImage.add(new Text("无配图哦"));
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          "details",
          arguments: _follow[index],
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
                _follow[index].content == null ? " " : _follow[index].content,
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
    _follow = Provider.of<MessageState>(context).follow;
    return _follow.length == 0
        ? Center(
            child: Text("暂无消息"),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _follow.length,
            itemBuilder: (context, index) {
              return Material(
                child: _items(index),
              );
            },
          );
  }
}
