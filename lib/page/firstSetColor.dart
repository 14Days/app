import 'package:furture/component/comment.dart';
import 'package:furture/provider/messageState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/userState.dart';
import 'package:furture/service/serviceMethod.dart';

class FirstSetColor extends StatefulWidget {
  @override
  _FirstSetColorState createState() => _FirstSetColorState();
}

class _FirstSetColorState extends State<FirstSetColor> {
  int _color;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
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
                  value: 0,
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
                  value: 1,
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
                  value: 2,
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
                  value: 3,
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
                  value: 4,
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
                  value: 5,
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
                  value: 6,
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
                  value: 7,
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
                  value: 8,
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
                  value: 9,
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
                  value: 10,
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
                  value: 11,
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavigation()),
                (route) => route == null);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("设置颜色"),
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
