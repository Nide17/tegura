class IsuzumaModel {
  String id;
  String title;
  String? description;
  // List<IsuzumaQuestion> questions;
  dynamic questions;

  IsuzumaModel({
    required this.id,
    required this.title,
    this.description,
    required this.questions,
  });

  // FROM JSON
  IsuzumaModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        questions = json['questions'];

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions,
    };
  }

  // TO STRING
  @override
  String toString() {
    return 'Isuzuma(id: $id, title: $title, description: $description, questions: $questions)';
  }

  // TO OBJECT
  IsuzumaModel toObject(Map<String, dynamic> map) {
    return IsuzumaModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      questions: map['questions'],
    );
  }
}

class IsuzumaQuestion {
  int id;
  String ingingoID;
  String isomoID;
  String? title;
  String? image;
  // List<IsuzumaOption> options;
  dynamic options;

  IsuzumaQuestion({
    required this.id,
    required this.ingingoID,
    required this.isomoID,
    this.title,
    this.image,
    required this.options,
  });

  // FROM JSON
  IsuzumaQuestion.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        ingingoID = json['ingingoID'],
        isomoID = json['isomoID'],
        title = json['title'],
        image = json['image'],
        options = json['options'];

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingingoID': ingingoID,
      'isomoID': isomoID,
      'title': title,
      'image': image,
      'options': options,
    };
  }

  // TO STRING
  @override
  String toString() {
    return 'Question(id: $id, ingingoID: $ingingoID, isomoID: $isomoID, title: $title, image: $image, options: $options)';
  }

  // TO OBJECT
  IsuzumaQuestion toObject(Map<String, dynamic> map) {
    return IsuzumaQuestion(
      id: map['id'],
      ingingoID: map['ingingoID'],
      isomoID: map['isomoID'],
      title: map['title'],
      image: map['image'],
      options: map['options'],
    );
  }
}

class IsuzumaOption {
  int id;
  String? text;
  String? image;
  bool isCorrect;

  IsuzumaOption({
    required this.id,
    this.text,
    this.image,
    required this.isCorrect,
  });

  // FROM JSON
  IsuzumaOption.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        image = json['image'],
        isCorrect = json['isCorrect'];

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'image': image,
      'isCorrect': isCorrect,
    };
  }

  // TO STRING
  @override
  String toString() {
    return 'Option(id: $id, text: $text, image: $image, isCorrect: $isCorrect)';
  }

  // TO OBJECT
  IsuzumaOption toObject(Map<String, dynamic> map) {
    return IsuzumaOption(
      id: map['id'],
      text: map['text'],
      image: map['image'],
      isCorrect: map['isCorrect'],
    );
  }
}
