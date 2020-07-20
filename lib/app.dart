import 'package:demofirebase/pages/home.dart';
import 'package:demofirebase/pages/login.dart';
import 'package:demofirebase/pages/register.dart';
import 'package:demofirebase/services/auth.dart';
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
      //declaring some routes to use them by name later
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (context) => MyHomePage());
          case "/login":
            return MaterialPageRoute(
              builder: (context) => LoginPage(),
              fullscreenDialog: true,
            );
          case "/register":
            return MaterialPageRoute(
              builder: (context) => RegisterPage(),
              fullscreenDialog: true,
            );
        }
      },
      home: Landing(),
    );
  }
}

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.instance.currentUser,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          return MyHomePage();
        } else if (snapshot.hasError) {
          return Text(snapshot.error);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
