import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';
import 'package:mybinder/screens/mybinder.dart';
import 'package:mybinder/screens/add_card.dart';
import 'package:mybinder/screens/settings.dart';

class Home extends StatefulWidget {
  String user;
  Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final MyBinder binder = new MyBinder();
  final List<Widget> _children = [MyBinder(), AddCard(), Settings()];
  final ApiHandler api = new ApiHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> initUser() async {
    bool response = await api.insertUser(auth.currentUser.uid);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                  new Padding(padding: const EdgeInsets.only(top: 10.0)),
                  Text("Carregando",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12))
                ],
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('MyBinder'),
            ),
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_sharp), label: 'Add Card'),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.settings),
                  label: 'Settings',
                )
              ],
            ),
          );
        });
  }
}
