import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tegura/models/score.dart';

class IsuzumaScoreService {
  // COLLECTIONS REFERENCE - FIRESTORE
  final CollectionReference isuzumaScoresCollection =
      FirebaseFirestore.instance.collection('scores');

  // CONSTRUCTOR
  IsuzumaScoreService();

// #############################################################################
// MODELING DATA
// #############################################################################
  // GET AMASUZUMA SCORES FROM A SNAPSHOT USING THE Isuzuma MODEL - _amasuzumaScoreFromSnapshot
  List<IsuzumaScoreModel> _amasuzumaScoreFromSnapshot(
      QuerySnapshot querySnapshot) {
    // GET THE DATA FROM THE SNAPSHOT
    return querySnapshot.docs.map((doc) {
      // GET THE DATA FROM THE SNAPSHOT
      final data = doc.data() as Map<String, dynamic>;

      // document id - Isuzuma id
      final id = doc.id;

      // CHECK IF THE FIELDS EXISTS BEFORE ASSIGNING TO THE VARIABLE
      final isuzumaID = data.containsKey('isuzumaID') ? data['isuzumaID'] : '';
      final takerID = data.containsKey('takerID') ? data['takerID'] : '';
      final marks = data.containsKey('marks') ? data['marks'] : 0;
      final totalMarks =
          data.containsKey('totalMarks') ? data['totalMarks'] : 0;
      final dateTaken = data.containsKey('dateTaken') ? data['dateTaken'] : '';
      final questions = data.containsKey('questions') ? data['questions'] : [];

      // RETURN A LIST OF AMASUZUMA SCORES FROM THE SNAPSHOT
      return IsuzumaScoreModel(
        // AMASUZUMA SCORES DATA
        id: id,
        isuzumaID: isuzumaID,
        takerID: takerID,
        marks: marks,
        totalMarks: totalMarks,
        dateTaken: dateTaken,
        questions: questions,
      );
    }).toList();
  }

  // GET ONE isuzuma FROM A SNAPSHOT USING THE isuzuma MODEL - _isuzumaScoreFromSnapshot
  // FUNCTION CALLED EVERY TIME THE AMASUZUMA SCORES DATA CHANGES
  IsuzumaScoreModel _isuzumaScoreFromSnapshot(
      DocumentSnapshot documentSnapshot) {
    // GET THE DATA FROM THE SNAPSHOT
    final data = documentSnapshot.data() as Map<String, dynamic>;

    // CHECK IF THE FIELDS EXIST BEFORE ASSIGNING TO THE VARIABLE
    final id = documentSnapshot.id;
    final isuzumaID = data.containsKey('isuzumaID') ? data['isuzumaID'] : '';
    final takerID = data.containsKey('takerID') ? data['takerID'] : '';
    final marks = data.containsKey('marks') ? data['marks'] : 0;
    final totalMarks = data.containsKey('totalMarks') ? data['totalMarks'] : 0;
    final dateTaken = data.containsKey('dateTaken') ? data['dateTaken'] : '';
    final questions = data.containsKey('questions') ? data['questions'] : [];

    // RETURN A LIST OF AMASUZUMA SCORES FROM THE SNAPSHOT
    return IsuzumaScoreModel(
      // AMASUZUMA SCORES
      id: id,
      isuzumaID: isuzumaID,
      takerID: takerID,
      marks: marks,
      totalMarks: totalMarks,
      dateTaken: dateTaken,
      questions: questions,
    );
  }

// #############################################################################
// GET DATA
// #############################################################################
  // GET ALL AMASUZUMA SCORES
  Stream<List<IsuzumaScoreModel>> get amasuzumabumenyiScores {
    return isuzumaScoresCollection.snapshots().map(_amasuzumaScoreFromSnapshot);
  }

  // GET ONE isuzuma SCORE
  Stream<IsuzumaScoreModel> getIsuzumaScore(String id) {
    return isuzumaScoresCollection
        .doc(id)
        .snapshots()
        .map(_isuzumaScoreFromSnapshot);
  }

  // GET SCORES BY TAKER ID
  Stream<List<IsuzumaScoreModel>> getScoresByTakerID(String takerID) {
    return isuzumaScoresCollection
        .where('takerID', isEqualTo: takerID)
        .snapshots()
        .map(_amasuzumaScoreFromSnapshot);
  }

  // CREATE OR UPDATE THE SCORE - ADD OR UPDATE - ONE SCORE PER TAKER PER ISUZUMA
  Future<void> createOrUpdateIsuzumaScore(
      String id,
      String isuzumaID,
      String takerID,
      int marks,
      int totalMarks,
      String dateTaken,
      List<dynamic> questions) async {
    // CREATE OR UPDATE THE SCORE
    return await isuzumaScoresCollection.doc(id).set({
      'isuzumaID': isuzumaID,
      'takerID': takerID,
      'marks': marks,
      'totalMarks': totalMarks,
      'dateTaken': dateTaken,
      'questions': questions,
    });
  }
}
// #############################################################################
// END OF FILE
// #############################################################################
