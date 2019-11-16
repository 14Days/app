import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import './config/application.dart';
import './provider/stateProvider.dart';
import './config/routes.dart';
import './page/loginPage.dart';
import './page/detailsPage.dart';

void main() {
  var category = Category();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Category>.value(value: category)
    ],
    child: MyApp(),
  ));
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
    return MaterialApp(
      title: 'FurtureApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      onGenerateRoute: Application.router.generator,
    );
  }
}
