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
  }

  Future<bool> initList() async {
    entries = await api.createBinder(auth.currentUser.uid);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initList(),
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (!snapshot.hasData) {
            // Future hasn't finished yet, return a placeholder
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
                          color: Colors.blue, fontWeight: FontWeight.bold))
                ],
              ),
            );
          }
          return Scaffold(
              body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Padding(padding: const EdgeInsets.only(top: 15.0)),
              Text(
                "*Durante a fase de desenvolvimento todo novo usuário terá algumas cartas na pasta por padrão",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              new Padding(padding: const EdgeInsets.only(top: 15.0)),
              Expanded(
                child: SizedBox(
                  child: new ListView.builder(
                    padding: const EdgeInsets.all(0.01),
                    itemCount: entries.length,
                    itemBuilder: _buildItemsForListView,
                  ),
                ),
              )
            ],
          ));
        });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      minLeadingWidth: 1,
      subtitle: Image.network(entries[index].imageUrl),
      title: Text(
        "Name: " +
            entries[index].cardName +
            "\nSet: " +
            entries[index].setName +
            "\n#" +
            entries[index].multiverseId,
        textAlign: TextAlign.center,
      ),
    );
  }
}
