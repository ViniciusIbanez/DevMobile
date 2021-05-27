class Binder {
  final String setName;
  final String multiverseId;
  final String imageUrl;
  final String cardName;

  Binder({this.setName, this.multiverseId, this.imageUrl, this.cardName});

  factory Binder.fromJson(Map<String, dynamic> json) {
    return Binder(
        setName: json['set_name'],
        multiverseId: json['multiverse_id'],
        cardName: json['name'],
        imageUrl: json['image_url']);
  }

  String get multiverse_id {
    return multiverseId;
  }
}
