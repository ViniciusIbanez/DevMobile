import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';
import 'package:mybinder/screens/mybinder.dart';
import 'package:mybinder/screens/add_card.dart';
import 'package:mybinder/screens/settings.dart';
import 'package:mybinder/binder.dart';

class Home extends StatefulWidget {
  String user;
  List<Binder> binder = [];
  Home({Key? key, required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final ApiHandler api = new ApiHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List<Binder> binder_list = [];
  final List<Binder> cards_list = [];
  bool isUserInit = false;
  bool shouldRetrieveCards = true;
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
    if (!isUserInit) {
      this.binder_list.clear();
      bool response =
          await api.initUser(auth.currentUser!.uid, this.binder_list);
      isUserInit = true;
    }

    return true;
  }

  Widget? getScreen(_currentIndex) {
    if (_currentIndex == 0) {
      return MyBinder(binder: this.binder_list);
    }
    if (_currentIndex == 1) {
      return AddCard(
        binder: this.binder_list,
        cards: [],
      );
    }

    return null;
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
            body: getScreen(_currentIndex),
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
              ],
            ),
          );
        });
  }
}
