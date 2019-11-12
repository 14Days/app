import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:furture/config/application.dart';
import 'package:furture/page/homeRecommend.dart';
import './config/routes.dart';
import './page/loginPage.dart';
import './page/registerPage.dart';
import 'package:furture/page/bottomNavigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp(){
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FurtureApp',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      onGenerateRoute: Application.router.generator,
    );
  }
}
