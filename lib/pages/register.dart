import 'package:demofirebase/services/auth.dart';
import 'package:demofirebase/services/databse.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage();
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var name = '';
  var email = '';
  var password = '';
  bool isLoading = false;
  DBService db = DBService();
  AuthService auth = AuthService();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  updateLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  showSnackBar(msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('$msg'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void onRegister() {
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      updateLoading();

      auth.registerWithEmail(email, password, name).then((value) async {
        //pushes the homepage
        Navigator.of(context).pushReplacementNamed('/');
      }).catchError((error) {
        updateLoading();
        showSnackBar(error.message);
      });
    } else {
      showSnackBar('All fields are required.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body:  ListView(
        padding: const EdgeInsets.all(30),
          children: <Widget>[
            const Text(
              'New Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Name', prefixIcon: Icon(Icons.account_circle)),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Email', prefixIcon: Icon(Icons.email)),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Password', prefixIcon: Icon(Icons.lock)),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Container(
              child: RaisedButton(
                child: Text('Register'),
                color: Theme.of(context).primaryColor,
                onPressed: isLoading ? null : onRegister,
              ),
              height: 35,
            ),
            const SizedBox(height: 60),
            FlatButton(
              child: Text(
                'Back to Login',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              highlightColor: Colors.amber[100],
              splashColor: Colors.amber[50],
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      
    );
  }
}
