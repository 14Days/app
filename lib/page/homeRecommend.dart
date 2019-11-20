import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
    super.initState(); //无名无参需要调用
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  @override
  // ignore: must_cal_super
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
  MessageModel messageModel;
  EasyRefreshController _refresh;

//  _RecommendBodyState({Key key, this.messageData}) : super(key: key);

  getMessage() async {
    final onValue = await homeRecommendService();
    setState(() {
      if (onValue['status'] == 'success') {
        messageModel = MessageModel.fromJson(onValue);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getMessage();
    _refresh = EasyRefreshController();
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  Widget imageItems(index) {
    List<Widget> images = []; //先建一个数组用于存放循环生成的widget
    for (var image in messageModel.data[index].imgsName) {
      images.add(
        new Container(
          child: Text(image.toString()),
//                Image.network(image,width: 500,height: 100,fit: BoxFit.cover,),
        ),
      );
    }
    return Row(
      children: images,
    );
//      GridView.builder(
//      itemCount: images.length,
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 2,
//          mainAxisSpacing: 20.0,
//          crossAxisSpacing: 10.0,
//          childAspectRatio: 1.0),
//      itemBuilder: (BuildContext context, int _index) {
//        //Widget Function(BuildContext context, int index)
//        return images[_index];
//      },
//    );
  }

  //定义单条推荐消息
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
          ),
        ),
        child: Column(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                messageModel.data[index].content,
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
              child: imageItems(index),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (messageModel == null || messageModel.data.length == 0) {
      return Center(
        child: Text("暂无消息"),
      );
//        child:EasyRefresh(
//        controller: _refresh,
//        enableControlFinishRefresh: true,
//        child: Center(
//          child: Text("暂无消息"),
//        ),
//        onRefresh: () async {
//          final onValue = await homeRecommendService();
//          setState(() {
//            if (onValue['status'] == 'success') {
//              messageModel = MessageModel.fromJson(onValue);
//            }
//          });
//          _refresh.resetLoadState();
//        },
//      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: messageModel.data.length,
        itemBuilder: (context, index) {
          return Material(child: _item(index));
        },
      );
//        EasyRefresh.custom(
//        controller: _refresh,
//        enableControlFinishRefresh: true,
//        enableControlFinishLoad: false,
//        slivers: <Widget>[
//          ListView.builder(
//            scrollDirection: Axis.vertical,
//            itemCount: messageModel.data.length,
//            itemBuilder: (context, index) {
//              return Material(child: _item(index));
//            },
//          ),
//        ],
//        onRefresh: () async {
//          final onValue = await homeRecommendService();
//          setState(() {
//            if (onValue['status'] == 'success') {
//              messageModel = MessageModel.fromJson(onValue);
//            }
//          });
//          _refresh.resetLoadState();
//        },
//      );
    }
  }
}
