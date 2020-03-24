import 'package:demofirebase/pages/home.dart';
import 'package:demofirebase/pages/login.dart';
import 'package:demofirebase/pages/register.dart';
import 'package:flutter/material.dart';

class DemoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (context) => MyHomePage());
          case "/login":
            return MaterialPageRoute(
                builder: (context) => LoginPage(), fullscreenDialog: true);
          case "/register":
            return MaterialPageRoute(
                builder: (context) => RegisterPage(), fullscreenDialog: true);
        }
      },

      home: Landing(),
    );
  }
}

class Landing extends StatelessWidget {
  final user = null;
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return LoginPage();
    } else {
      return MyHomePage();
    }
  }
}
