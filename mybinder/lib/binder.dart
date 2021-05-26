class Binder {
  final String setName;
  final String multiverseId;
  final String imageUrl;

  Binder({this.setName, this.multiverseId, this.imageUrl});

  factory Binder.fromJson(Map<String, dynamic> json) {
    return Binder(
        setName: json['set_name'],
        multiverseId: json['multiverse_id'],
        imageUrl: json['image_url']);
  }

  String get multiverse_id {
    return multiverseId;
  }
}
