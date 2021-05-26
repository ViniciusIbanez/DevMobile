import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';
import 'package:mybinder/binder.dart';

class MyBinder extends StatefulWidget {
  String user;
  MyBinder({Key key, this.user}) : super(key: key);

  @override
  _MyBinderState createState() => _MyBinderState();
}

class _MyBinderState extends State<MyBinder> {
  final ApiHandler api = new ApiHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Binder> entries = [];

  @override
  Future<void> initState() {
    super.initState();
    initList();
  }

  Future<void> initList() async {
    entries = await api.createBinder(auth.currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 200.0,
            child: new ListView.builder(
              padding: const EdgeInsets.all(0.01),
              itemCount: entries.length,
              itemBuilder: _buildItemsForListView,
            ),
          ),
        )
      ],
    ));
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Image.network(entries[index].imageUrl),
      subtitle: Text(
        "Set: " + entries[index].setName + "#" + entries[index].multiverseId,
        textAlign: TextAlign.center,
      ),
    );
  }
}
