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
  List<Option>? options = [];

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
}
