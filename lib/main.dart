import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/physics.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/page/detailsPage.dart';
import 'package:furture/page/secondComment.dart';
import 'package:furture/provider/messageState.dart';
import 'package:furture/provider/noticeState.dart';
import 'package:furture/service/startService.dart';
import 'package:furture/service/userService.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './config/application.dart';
import './config/routes.dart';
import './page/loginPage.dart';
import 'provider/userState.dart';

import 'package:flutter/services.dart';

bool _ok = false;
//学习使用
void main() async {
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  var getUser = await SharedPreferences.getInstance();
  var username = getUser.get('username');
  var password = getUser.get('password');
  if (username == '' || username == null) {
    _ok = false;
  } else {
    final onValue = await loginService(username, password);
    if (onValue['status'] == 'success') {
      final toColor = await getUserService();
      if (toColor['status'] == 'success') {
        _ok = true;
      } else {
        _ok = false;
      }
    } else {
      _ok = false;
    }
  }
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          return RefreshConfiguration(
            headerBuilder: () => WaterDropHeader(),
            footerBuilder: () => ClassicFooter(),
            headerTriggerDistance: 80.0,
            springDescription:
                SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
            maxOverScrollExtent: 100,
            maxUnderScrollExtent: 0,
            enableScrollWhenRefreshCompleted: true,
            enableLoadingWhenFailed: true,
            hideFooterWhenNotFull: false,
            enableBallisticLoad: true,
            child: MaterialApp(
              title: 'i deer',
              theme: ThemeData(
                primaryColor: Color.fromARGB(255, 249, 249, 249),
              ),
              home: _ok == true ? BottomNavigation() : LoginPage(),
              routes: {
                "details": (context) => DetailsPage(),
                "replys": (context) => SecondCommentPage(),
              },
              onGenerateRoute: Application.router.generator,
            ),
          );
        },
      ),
    );
  }
}
