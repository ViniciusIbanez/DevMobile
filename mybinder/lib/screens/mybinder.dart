import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybinder/api_handler.dart';
import 'package:mybinder/binder.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyBinder extends StatefulWidget {
  List<Binder> binder;
  MyBinder({Key? key, required this.binder}) : super(key: key);

  @override
  _MyBinderState createState() => _MyBinderState();
}

class _MyBinderState extends State<MyBinder> {
  final ApiHandler api = new ApiHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Binder> entries = [];

  @override
  initState() {
    super.initState();
  }

  Future<bool> initList(List<Binder> binder) async {
    //entries = await api.createBinder(auth.currentUser.uid);
    entries = binder;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initList(widget.binder),
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
              if (widget.binder.length == 0)
                Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 180,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Image(
                              image: new AssetImage("assets/logo.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          //Padding(padding: const EdgeInsets.only(top: 50.0))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      width: 200,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'Agne',
                        ),
                        textAlign: TextAlign.center,
                        child: AnimatedTextKit(
                          repeatForever: false,
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TypewriterAnimatedText(
                                'Nenhuma carta encontrada, comece a criar a sua pasta!!'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 15.0)),
                  ],
                ),
              Expanded(
                child: SizedBox(
                  child: new ListView.builder(
                    padding: const EdgeInsets.all(0.01),
                    itemCount: entries.length,
                    itemBuilder: _buildItemsForListView,
                  ),
                ),
              ),
            ],
          ));
        });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
        minLeadingWidth: 1,
        title: Container(
          child: Column(
            children: [
              Text(
                "Name: " +
                    entries[index].cardName +
                    "\nSet: " +
                    entries[index].setName +
                    "\n#" +
                    entries[index].multiverseId,
                textAlign: TextAlign.center,
              ),
              Image.network(entries[index].imageUrl),
              new Padding(padding: const EdgeInsets.only(top: 50.0)),
            ],
          ),
        ));
  }
}
