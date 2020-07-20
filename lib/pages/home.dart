import 'package:demofirebase/services/auth.dart';
import 'package:demofirebase/services/databse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBService db = DBService.instance;
  AuthService auth = AuthService.instance;
  String userName;

  Future getUserData() async {
    final FirebaseUser currentUser = await auth.currentUser;
    final userDoc = await db.getUserDoc(currentUser.uid);
    setState(() {
      userName = userDoc['name'];
    });
  }

  initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: userName == null
                  ? Text("Loading...")
                  : Text(
                      "Welcome, $userName",
                      style: Theme.of(context).textTheme.headline6,
                    ),
              height: 40,
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: (){
                auth.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}
