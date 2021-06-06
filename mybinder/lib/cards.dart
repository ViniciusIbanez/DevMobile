class Cards {
  final String setName;
  final String multiverseId;
  final String imageUrl;
  final String cardName;

  Cards({this.setName, this.multiverseId, this.imageUrl, this.cardName});

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
        setName: json['set_name'],
        multiverseId: json['multiverse_id'],
        cardName: json['name'],
        imageUrl: json['image_url']);
  }

  String get name {
    return cardName;
  }

  String get set_name {
    return setName;
  }
}
