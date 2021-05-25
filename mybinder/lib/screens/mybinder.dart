import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';

class MyBinder extends StatefulWidget {
  final String user;
  const MyBinder({Key key, this.user}) : super(key: key);

  @override
  _MyBinderState createState() => _MyBinderState();
}

class _MyBinderState extends State<MyBinder> {
  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final ApiHandler api = new ApiHandler();
    if (auth.currentUser != null) {
      print("###### " + auth.currentUser.uid);
      api.insertUser(auth.currentUser.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('MyBinder'),
        ),
        body: Column(
          children: [
            new MaterialButton(
                height: 35,
                minWidth: 220,
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: Text('Teste', style: TextStyle(fontSize: 20)),
                onPressed: () async {}),
          ],
        ),
      ),
    );
  }
}
