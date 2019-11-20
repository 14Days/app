import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/stateProvider.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SetAvatar extends StatefulWidget {
  @override
  _SetAvatarState createState() => _SetAvatarState();
}

class _SetAvatarState extends State<SetAvatar> {
  File _image;

  String _showText = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context, listen: false);
    user.getUserInfo();
    String _imgPath = user.avatar;
    void testSet() async {
      FormData image = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          _image.path,
          filename:
              basenameWithoutExtension(_image.path) + extension(_image.path),
        )
      });
      final onValue = await setAvatarService(image);
      if (onValue['status'] == 'success') {
        user.getUserInfo();
        Navigator.pop(context);
      } else {
        _showText = "设置失败";
        final _snackBar = new SnackBar(
          content: new Text(_showText),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        );
        Scaffold.of(context).showSnackBar(_snackBar);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("设置头像"),
        actions: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text(
              "完成",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              testSet();
              user.getUserInfo();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: _takePhoto,
                    child: Text("拍照"),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: _openGallery,
                    child: Text("选择照片"),
                  ),
                ],
              ),
              imageView(_image),
            ],
          ),
        ),
      ),
    );
  }

  /*图片控件*/
  Widget imageView(_image) {
    if (_image == null) {
      return Center(
        child: Text("图片会在这里显示"),
      );
    } else {
      return Container(
        height: 90,
        width: 90,
        color: Colors.white,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white70,
            backgroundImage: FileImage(_image),
          ),
        ),
      );
    }
  }

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
