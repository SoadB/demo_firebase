import 'package:flutter/material.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email)
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock)
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Login'),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            SizedBox(height: 60),
            FlatButton(
              child: Text(
                'Back to Login',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold
                ),
              ),
              highlightColor: Colors.amber[100],
              splashColor:Colors.amber[50] ,
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
            )
          ],
        ),
      ),

    );
  }
}
