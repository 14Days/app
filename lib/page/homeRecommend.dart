import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:furture/config/routes.dart';
import 'package:furture/model/entity.dart';
import 'package:furture/provider/messageState.dart';
import 'package:provider/provider.dart';
import 'package:furture/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'PhotoView.dart';

List<MessageData> _recommend = [];

class HomeRecommend extends StatefulWidget {
  @override
  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<MessageState>(context).updateRecommend();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return RecommendBody();
  }
}

//推荐类
// ignore: must_be_immutable
class RecommendBody extends StatefulWidget {
  @override
  _RecommendBodyState createState() => _RecommendBodyState();
}

class _RecommendBodyState extends State<RecommendBody> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000), () async {
      await Provider.of<MessageState>(context).updateRecommend();
    });
    _refreshController.refreshCompleted();
  }

//  void _onLoading() async {
//    // monitor network fetch
//    await Future.delayed(Duration(milliseconds: 1000));
//
////     if failed,use loadFailed(),if no data return,use LoadNodata()
//
//    if (mounted) setState(() {});
//    _refreshController.loadComplete();
//  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _items(index) {
    List<Widget> images = [];
    List<Widget> noImage = [];
    for (var image in _recommend[index].imgsName) {
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
          arguments: _recommend[index],
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
                _recommend[index].content != null
                    ? _recommend[index].content
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
    _recommend = Provider.of<MessageState>(context).recommend;
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: WaterDropHeader(
        refresh: CupertinoActivityIndicator(),
        complete: Center(
          child: Text(
            "刷新完成",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15
            ),
          ),
        ),
      ),
      onRefresh: _onRefresh,
//      enablePullUp: true,
//      footer: CustomFooter(
//        builder: (BuildContext context, LoadStatus mode) {
//          Widget body;
//          if (mode == LoadStatus.idle) {
//            body = Text("pull up load");
//          } else if (mode == LoadStatus.loading) {
//            body = CupertinoActivityIndicator();
//          } else if (mode == LoadStatus.failed) {
//            body = Text("Load Failed!Click retry!");
//          } else {
//            body = Text("No more Data");
//          }
//          return Container(
//            height: 10,
//            child: Center(child: body),
//          );
//        },
//      ),
//      onLoading: _onLoading,

      child: _recommend.length == 0
          ? Container(
              alignment: Alignment.center,
              child: Text("暂无推荐消息"),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _recommend.length,
              itemBuilder: (context, index) {
                return Material(
                  child: _items(index),
                );
              },
            ),
    );
  }
}
