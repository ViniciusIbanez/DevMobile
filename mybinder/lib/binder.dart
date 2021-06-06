import 'dart:convert';
import 'dart:convert' as convert;

class Binder {
  final String setName;
  final String multiverseId;
  final String imageUrl;
  final String cardName;

  Binder(
      {required this.setName,
      required this.multiverseId,
      required this.imageUrl,
      required this.cardName});

  // factory Binder.fromJson(Map<String, dynamic> json) {
  //   return Binder(
  //       setName: json['set_name'],
  //       multiverseId: json['multiverse_id'],
  //       cardName: json['name'],
  //       imageUrl: json['image_url']);
  // }

  static Binder fromJson(Map<String, dynamic> json) => Binder(
      setName: json['set_name'],
      multiverseId: json['multiverse_id'],
      cardName: json['name'],
      imageUrl: json['image_url']);

  String get multiverse_id {
    return multiverseId;
  }
}
