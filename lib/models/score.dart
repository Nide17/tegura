class IsuzumaScoreModel {
  String id;
  String isuzumaID;
  String takerID;
  int marks;
  int totalMarks;
  DateTime dateTaken;
  // List<ScoreQuestion> questions;
  dynamic questions;

  IsuzumaScoreModel({
    required this.id,
    required this.isuzumaID,
    required this.takerID,
    required this.marks,
    required this.totalMarks,
    required this.dateTaken,
    required this.questions,
  });

  // FROM JSON
  IsuzumaScoreModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isuzumaID = json['isuzumaID'],
        takerID = json['takerID'],
        marks = json['marks'],
        totalMarks = json['totalMarks'],
        dateTaken = json['dateTaken'],
        questions = json['questions'];

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isuzumaID': isuzumaID,
      'takerID': takerID,
      'marks': marks,
      'totalMarks': totalMarks,
      'dateTaken': dateTaken,
      'questions': questions,
    };
  }

  // TO STRING
  @override
  String toString() {
    return 'IsuzumaScoreModel(id: $id, isuzumaID: $isuzumaID, takerID: $takerID, marks: $marks, totalMarks: $totalMarks, dateTaken: $dateTaken, questions: $questions)';
  }

  // TO OBJECT
  IsuzumaScoreModel toObject(Map<String, dynamic> map) {
    return IsuzumaScoreModel(
      id: map['id'],
      isuzumaID: map['isuzumaID'],
      takerID: map['takerID'],
      marks: map['marks'],
      totalMarks: map['totalMarks'],
      dateTaken: map['dateTaken'],
      questions: map['questions'],
    );
  }
}

  // TO MAP
class ScoreQuestion {
  int id;
  String ingingoID;
  String isomoID;
  String? title;
  String? image;
  // List<ScoreOption> options;
  dynamic options;
  bool isAnswered;


  ScoreQuestion({
    required this.id,
    required this.ingingoID,
    required this.isomoID,
    this.title,
    this.image,
    required this.options,
    this.isAnswered = false,
  });

  // TO STRING
  @override
  String toString() {
    return 'ScoreQuestion(id: $id, ingingoID: $ingingoID, isomoID: $isomoID, title: $title, image: $image, options: $options, isAnswered: $isAnswered)';
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingingoID': ingingoID,
      'isomoID': isomoID,
      'title': title,
      'image': image,
      'options': options,
      'isAnswered': isAnswered,
    };
  }

  // TO OBJECT
  ScoreQuestion toObject(Map<String, dynamic> map) {
    return ScoreQuestion(
      id: map['id'],
      ingingoID: map['ingingoID'],
      isomoID: map['isomoID'],
      title: map['title'],
      image: map['image'],
      options: map['options'],
      isAnswered: map['isAnswered'],
    );
  }
}

class ScoreOption {
  int id;
  String? text;
  String? image;
  bool isCorrect;
  bool? isChoosen;

  ScoreOption({
    required this.id,
    this.text,
    this.image,
    required this.isCorrect,
    this.isChoosen,
  });

  // FROM JSON
  ScoreOption.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        image = json['image'],
        isCorrect = json['isCorrect'],
        isChoosen = json['isChoosen'];

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'image': image,
      'isCorrect': isCorrect,
      'isChoosen': isChoosen,
    };
  }

  // TO STRING
  @override
  String toString() {
    return 'Option(id: $id, text: $text, image: $image, isCorrect: $isCorrect, isChoosen: $isChoosen)';
  }

  // TO OBJECT
  ScoreOption toObject(Map<String, dynamic> map) {
    return ScoreOption(
      id: map['id'],
      text: map['text'],
      image: map['image'],
      isCorrect: map['isCorrect'],
      isChoosen: map['isChoosen'],
    );
  }
}
