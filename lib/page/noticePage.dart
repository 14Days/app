import 'package:flutter/material.dart';
import 'package:furture/provider/noticeState.dart';
import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "通知",
        ),
      ),
      body: new Container(
        child: NoticeBody(),
      ),
    );
  }
}

//通知类
// ignore: must_be_immutable

class NoticeBody extends StatefulWidget {
  @override
  _NoticeBodyState createState() => _NoticeBodyState();
}

class _NoticeBodyState extends State<NoticeBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<NoticeState>(context).updateNotice();
    });
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  //定义通知消息
  // ignore: missing_return
  Widget _item(index) {
    final notice = Provider.of<NoticeState>(context);
    if (notice.items[index].content != null) {
      return Container(
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        padding: const EdgeInsets.all(10.0),
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
          children: <Widget>[
            Container(
              height: 55.0,
              width: 55.0,
              color: Colors.white,
              child: GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 5,
                    right: 5,
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white70,
                    backgroundImage: NetworkImage(
                      Utils.webImgPath(notice.items[index].avatar == null
                          ? 'avatar.png'
                          : notice.items[index].avatar),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      notice.items[index].createAt,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      notice.items[index].content,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notice = Provider.of<NoticeState>(context);
    return notice.items == null
        ? Center(
            child: Text(
              "暂无通知",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: notice.items.length,
            itemBuilder: (context, index) {
              return Material(
                child: _item(index),
              );
            },
          );
  }
}
