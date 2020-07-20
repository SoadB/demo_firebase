import 'package:demofirebase/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = '';
  var password = '';
  bool isLoading = false;

  updateLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  showSnackBar(String msg, BuildContext context) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('$msg'),
        behavior: SnackBarBehavior.fixed,
      ));
  }

  Future onLogin(BuildContext context) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      updateLoading();
      try {
        await AuthService.instance.loginWithEmail(email, password);
        Navigator.of(context).pushReplacementNamed('/');
      } catch (e) {
        updateLoading();
        showSnackBar(e.message, context);
      }
    } else {
      showSnackBar('Email & password fields cannot be empty.', context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Builder(
          builder: (context) => Center(
                child: ListView(
                  padding: EdgeInsets.all(30),
                  children: <Widget>[
                    Text(
                      'Welcome again!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50),
                    RaisedButton.icon(
                      onPressed: (){},
                      icon: Image.asset('assets/google.png', width: 20),
                      label: Text("Login with Google"),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "OR",
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: RaisedButton(
                        child: Text('Login'),
                        color: Theme.of(context).primaryColor,
                        onPressed: isLoading ? null : () => onLogin(context),
                      ),
                      height: 35,
                    ),
                    SizedBox(height: 60),
                    Text(
                      'Don\'t have account yet?',
                      textAlign: TextAlign.center,
                    ),
                    FlatButton(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      highlightColor: Colors.amber[100],
                      splashColor: Colors.amber[50],
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                    )
                  ],
                ),
              )),
    );
  }
}
