import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ApiHandler {
  ApiHandler._();

  factory ApiHandler() => _instance;

  static final ApiHandler _instance = ApiHandler._();

  bool _initialized = false;
  String _token = "";

  Future<void> init(String user) async {
    String _user = user;
  }

  Future<void> insertUser(String user) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    //var url = Uri.https('my-binder-api-staging.herokuapp.com', '/user/insert');

    // Await the http get response, then decode the json-formatted response.
    print("### Inserting new user");
    final response = http.post(
      Uri.parse('https://my-binder-api-staging.herokuapp.com/user/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': user,
      }),
    );
  }
}
