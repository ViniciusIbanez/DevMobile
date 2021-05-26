import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mybinder/binder.dart';

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

  Future<List<Binder>> createBinder(String user) async {
    final response = await http.post(
      Uri.parse('https://my-binder-api-staging.herokuapp.com/binder/retrieve'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': user,
      }),
    );

    if (response.statusCode == 200) {
      List<Binder> list = <Binder>[];
      for (Object card in jsonDecode(response.body)['body']['cards']) {
        list.add(Binder.fromJson(card));
      }
      return list;
    } else {
      throw Exception('Failed to create binder.');
    }
  }
}
