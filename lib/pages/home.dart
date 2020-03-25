import 'dart:io';

import 'package:demofirebase/services/auth.dart';
import 'package:demofirebase/services/databse.dart';
import 'package:demofirebase/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBService db = DBService();
  AuthService auth = AuthService();
  StorageService storage = StorageService();
  initState() {
    super.initState();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    await storage.uploadFile(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
      ),
      body: FutureBuilder(
          future: auth.currentUser(),
          builder: (context, user) {
            if (!user.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
              stream: db.getUserDoc(user.data.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: snapshot.data['image'] == null
                              ? AssetImage('assets/placeholder.jpg')
                              : NetworkImage(snapshot.data['image'])),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Hello ${snapshot.data['name']}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      RaisedButton(
                        child: Text('Upload new image'),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          await getImage();
                          setState(() {
                            db = DBService();
                          });
                        },
                      ),
                      RaisedButton(
                        child: Text('Sign Out'),
                        onPressed: () {
                          auth.signOut();
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
