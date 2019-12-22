import 'dart:io';
import 'package:dio/dio.dart';
import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/userState.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SetAvatar extends StatefulWidget {
  @override
  _SetAvatarState createState() => _SetAvatarState();
}

class _SetAvatarState extends State<SetAvatar> {
  File _image;
  String _avatar;
  String _showText = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context, listen: false);
    _avatar = user.avatar;
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
        Navigator.pop(context);
        user.getUserInfo();
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
          FlatButton(
            color: MyColors.colorWhite,
            child: Text(
              "完成",
              style: TextStyle(
                color: MyColors.colorBlack,
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
              SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                child: imageView(_image),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new InkWell(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10),
                                height: 50.0,
                                alignment: Alignment.topCenter,
                                child: Text("拍照"),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _takePhoto();
                              },
                            ),
                            new InkWell(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10),
                                height: 50.0,
                                alignment: Alignment.topCenter,
                                child: Text("从相册中选择"),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _openGallery();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*图片控件*/
  Widget imageView(_image) {
    if (_image == null) {
      return Container(
        height: 90,
        width: 90,
        color: MyColors.colorWhite,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white70,
            backgroundImage: _avatar != null
                ? NetworkImage(Utils.myImgPath(_avatar))
                : AssetImage('assets/images/logo.png'),
          ),
        ),
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
