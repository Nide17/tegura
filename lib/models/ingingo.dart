class Option {
  String? title;
  String? text;
  String? imageUrl;
  String? imageTitle;
  String? imageDesc;

  Option({
    this.title,
    this.text,
    this.imageUrl,
    this.imageTitle,
    this.imageDesc,
  });

  Option.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    imageUrl = json['imageUrl'];
    imageTitle = json['imageTitle'];
    imageDesc = json['imageDesc'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'imageUrl': imageUrl,
      'imageTitle': imageTitle,
      'imageDesc': imageDesc,
    };
  }
}

// MODEL TO REPRESENT THE INGINGO
class IngingoModel {
  String id = '';
  String isomoId = '';
  String? title = '';
  String? text = '';
  String? imageUrl = '';
  String? imageTitle = '';
  String? imageDesc = '';
  dynamic options = [];

  // CONSTRUCTOR
  IngingoModel({
    required this.id,
    required this.isomoId,
    this.title,
    this.text,
    this.imageUrl,
    this.imageTitle,
    this.imageDesc,
    this.options,
  });

  // FROM JSON
  IngingoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isomoId = json['isomoId'];
    title = json['title'];
    text = json['text'];
    imageUrl = json['imageUrl'];
    imageTitle = json['imageTitle'];
    imageDesc = json['imageDesc'];
    options = json['options'];
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isomoId': isomoId,
      'title': title,
      'text': text,
      'imageUrl': imageUrl,
      'imageTitle': imageTitle,
      'imageDesc': imageDesc,
      'options': options,
    };
  }

  // TO STRING
  @override
  String toString() {
    return 'IngingoModel(id: $id, isomoId: $isomoId, title: $title, text: $text, imageUrl: $imageUrl, imageTitle: $imageTitle, imageDesc: $imageDesc, options: $options)';
  }

  // TO OBJECT
  IngingoModel toObject(Map<String, dynamic> map) {
    return IngingoModel(
      id: map['id'],
      isomoId: map['isomoId'],
      title: map['title'],
      text: map['text'],
      imageUrl: map['imageUrl'],
      imageTitle: map['imageTitle'],
      imageDesc: map['imageDesc'],
      options: map['options'],
    );
  }
}
