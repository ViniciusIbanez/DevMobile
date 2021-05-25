
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ApiHandler {

  ApiHandler._();

  factory ApiHandler() => _instance;

  static final ApiHandler _instance = ApiHandler._();

  bool _initialized = false;
  String _token = "";

  Future<void> init() async {
    
  }

  void insertUser() async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url =
      Uri.https('my-binder-api-staging.herokuapp.com', '/user/insert', {'user': 'teste'});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    // var jsonResponse =
    //     convert.jsonDecode(response.body) as Map<String, dynamic>;
    // var itemCount = jsonResponse['totalItems'];
    print('Deu certo');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

}