import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/page/detailsPage.dart';
import 'package:furture/page/secondComment.dart';
import 'package:furture/provider/messageState.dart';
import 'package:furture/provider/noticeState.dart';
import 'package:provider/provider.dart';
import './config/application.dart';
import './config/routes.dart';
import './page/loginPage.dart';
import 'provider/userState.dart';

void main() {
  runApp(MyApp());
}

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
        ChangeNotifierProvider(builder: (_) => UserState(),),
        ChangeNotifierProvider(builder: (_) => MessageState(),),
        ChangeNotifierProvider(builder: (_) => NoticeState(),),
      ],
      child: Consumer<UserState>(
        builder: (context,userState, _){
          return MaterialApp(
            title: 'FurtureApp',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LoginPage(),
            routes: {
              "details" : (context) => DetailsPage(),
              "replys" : (context) => SecondCommentPage(),
            },
            onGenerateRoute: Application.router.generator,
          );
        },
      ),
    );
  }
}
