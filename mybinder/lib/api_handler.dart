import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mybinder/binder.dart';
import 'package:mybinder/cards.dart';

class ApiHandler {
  ApiHandler._();

  factory ApiHandler() => _instance;

  static final ApiHandler _instance = ApiHandler._();

  bool _initialized = false;
  String _token = "";

  Future<void> init(String user) async {
    String _user = user;
  }

  Future<bool> insertUser(String user) async {
    final response = await http.post(
      Uri.parse('https://my-binder-api-staging.herokuapp.com/user/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': user,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to validate user');
    }
  }

  Future<bool> initUser(String user, List<Binder> binder) async {
    print("## Init User");
    final response = await http.post(
      Uri.parse('https://my-binder-api-staging.herokuapp.com/user/init'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': user,
      }),
    );

    if (response.statusCode == 200) {
      for (Object card in jsonDecode(response.body)['body']['cards']) {
        binder.add(Binder.fromJson(card));
      }

      return true;
    } else {
      throw Exception('Failed to create binder.');
    }
  }

  Future<bool> retrieveAllCards(List<Binder> cards) async {
    print("## Retrieve all cards");
    final response = await http.get(
        Uri.parse('https://my-binder-api-staging.herokuapp.com/cards/all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    //.timeout(const Duration(seconds: 15))

    print(response.statusCode);
    if (response.statusCode == 200) {
      for (Object card in jsonDecode(response.body)['body']['cards']) {
        cards.add(Binder.fromJson(card));
      }

      return true;
    } else {
      throw Exception('Failed to create binder.');
    }
  }

  Future<List<Binder>> createBinder(String user) async {
    print("Retrieving Binder Object");
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

  Future<bool> insertRandomCard(String user) async {
    final response = await http.post(
      Uri.parse(
          'https://my-binder-api-staging.herokuapp.com/card/insert-random'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': user,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add new random card');
    }
  }
}
