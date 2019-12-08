import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/page/detailsPage.dart';
import 'package:furture/page/secondComment.dart';
import 'package:furture/provider/messageState.dart';
import 'package:furture/provider/noticeState.dart';
import 'package:furture/service/startService.dart';
import 'package:furture/service/userService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './config/application.dart';
import './config/routes.dart';
import './page/loginPage.dart';
import 'provider/userState.dart';

//学习使用
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  var username;
  var password;
  bool _ok = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void choose() async {
      var getUser = await SharedPreferences.getInstance();
      username = getUser.get('username');
      password = getUser.get('password');
      if (username == '') {
        return;
      } else {
        final onValue = await loginService(username, password);
        if (onValue['status'] == 'success') {
          final toColor = await getUserService();
          if (toColor['status'] == 'success') {
            _ok = true;
          }
        }
      }
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => UserState(),
        ),
        ChangeNotifierProvider(
          builder: (_) => MessageState(),
        ),
        ChangeNotifierProvider(
          builder: (_) => NoticeState(),
        ),
      ],
      child: Consumer<UserState>(
        builder: (context, userState, _) {
          choose();
          return MaterialApp(
            title: 'FurtureApp',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: _ok == true ? BottomNavigation() : LoginPage(),
            routes: {
              "details": (context) => DetailsPage(),
              "replys": (context) => SecondCommentPage(),
            },
            onGenerateRoute: Application.router.generator,
          );
        },
      ),
    );
  }
}
