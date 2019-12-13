import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/userState.dart';
import 'package:furture/service/serviceMethod.dart';

class SetColor extends StatefulWidget {
  @override
  _SetColorState createState() => _SetColorState();
}

class _SetColorState extends State<SetColor> {
  int _color;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _color = Provider.of<UserState>(context).color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    _color = user.color;
    List<String> colors = [
      "red",
      "yellow",
      "green",
      "black",
      "brown",
      "orange",
      "purple",
      "grey",
      "white",
      "pink",
      "golden",
      "silvery",
    ];
    Widget colorForm() {
      return new StatefulBuilder(
        builder: (
          context,
          StateSetter setState,
        ) {
          return Column(
            children: <Widget>[
              Flexible(
                child: RadioListTile<int>(
                  value: 1,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.red,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[0]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 2,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.yellow,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[1]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 3,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.green,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[2]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 4,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.black,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[3]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 5,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.brown,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[4]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 6,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.orange,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[5]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 7,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.purple,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[6]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 8,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.grey,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[7]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 9,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.white,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[8]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 10,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Colors.pink,
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[9]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 11,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Color.fromARGB(255, 255, 215, 0),
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[10]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 12,
                  activeColor: MyColors.colorOrange,
                  groupValue: _color,
                  title: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        color: Color.fromARGB(125, 192, 192, 192),
                        child: SizedBox(
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(colors[11]),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _color = value;
                    });
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    void testSet() async {
      final onValue = await postColorService(user.color);
      if (onValue['status'] == 'success') {
//        Provider.of<MessageState>(context).updateRecommend();
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("设置颜色"),
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
              user.setColor(_color);
              testSet();
            },
          ),
        ],
      ),
      body: Container(
        child: colorForm(),
      ),
    );
  }
}
