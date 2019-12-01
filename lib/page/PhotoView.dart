import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

//详情页点击图片查看大图
class PhotoViewPage extends StatelessWidget {
  const PhotoViewPage({
    this.imageProvider,
    this.minScale, //最大缩放倍数
    this.maxScale, //最小缩放倍数
  });

  final ImageProvider imageProvider;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery
              .of(context)
              .size
              .height,
        ),
        child: GestureDetector(
          child: Container(
            child: PhotoView(
              imageProvider: imageProvider,
              minScale: minScale,
              maxScale: maxScale,
              enableRotation: true,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

}
