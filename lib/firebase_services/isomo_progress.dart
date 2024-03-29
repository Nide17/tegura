import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tegura/models/course_progress.dart';

class CourseProgressService {
  // COLLECTIONS REFERENCE - FIRESTORE
  final CollectionReference progressCollection =
      FirebaseFirestore.instance.collection('progresses');

  CourseProgressService();

// #############################################################################
// MODELING DATA
// #############################################################################
  // GET progresses FROM A SNAPSHOT USING THE PROGRESS MODEL - _progressesFromSnapshot
  // FUNCTION CALLED EVERY TIME THE progresses DATA CHANGES
  List<CourseProgressModel> _progressesFromSnapshot(
      QuerySnapshot querySnapshot) {
    // GET THE DATA FROM THE SNAPSHOT
    return querySnapshot.docs.map((doc) {
      // GET THE DATA FROM THE SNAPSHOT
      final data = doc.data() as Map<String, dynamic>;

      // CHECK IF THE FIELDS EXISTS BEFORE ASSIGNING TO THE VARIABLE
      final id = data.containsKey('id') ? data['id'] : '';
      final userId = data.containsKey('userId') ? data['userId'] : '';
      final courseId = data.containsKey('courseId') ? data['courseId'] : 0;
      final currentIngingo =
          data.containsKey('currentIngingo') ? data['currentIngingo'] : 0;
      final totalIngingos =
          data.containsKey('totalIngingos') ? data['totalIngingos'] : 0;

      // RETURN A LIST OF progresses FROM THE SNAPSHOT
      return CourseProgressModel(
        // PROGRESSES DATA
        id: id,
        userId: userId,
        courseId: courseId,
        currentIngingo: currentIngingo,
        totalIngingos: totalIngingos,
      );
    }).toList();
  }

  // GET ONE USER progress ON A COURSE FROM A SNAPSHOT USING THE PROGRESS MODEL - _progressFromSnapshot
  // FUNCTION CALLED EVERY TIME THE progresses DATA CHANGES
  CourseProgressModel _progressFromSnapshot(DocumentSnapshot documentSnapshot) {
    // GET THE DATA FROM THE SNAPSHOT
    final data = documentSnapshot.data() as Map<String, dynamic>;

    // CHECK IF THE FIELDS EXIST BEFORE ASSIGNING TO THE VARIABLE
    final id = data.containsKey('id') ? data['id'] : '';
    final userId = data.containsKey('userId') ? data['userId'] : '';
    final courseId = data.containsKey('courseId') ? data['courseId'] : 0;
    final currentIngingo =
        data.containsKey('currentIngingo') ? data['currentIngingo'] : 0;
    final totalIngingos =
        data.containsKey('totalIngingos') ? data['totalIngingos'] : 0;

    // RETURN A LIST OF progresses FROM THE SNAPSHOT
    return CourseProgressModel(
      // PROGRESSES DATA
      id: id,
      userId: userId,
      courseId: courseId,
      currentIngingo: currentIngingo,
      totalIngingos: totalIngingos,
    );
  }

// #############################################################################
// FUNCTIONS FOR INTERACTING WITH THE DATABASE
// #############################################################################

  // GET A LIST OF PROGRESSES OF USER ON finished and unfinished progress ON A COURSE STREAM
  Stream<List<CourseProgressModel?>>? getUserProgresses(String? uid) {
    // CHECK IF CURRENT USER UID IS NULL, IF IT IS, RETURN NULL
    if (uid == null || uid == '') return null;

// IF FINISHED, RETURN WHERE totalIngingos EQUAL TO currentIngingo
    return progressCollection
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map(_progressesFromSnapshot);
  }

  // GET ONE USER progress ON A COURSE STREAM
  Stream<CourseProgressModel?>? getProgress(String? uid, int? courseId) {
    // CHECK IF CURRENT USER UID IS NULL, IF IT IS, RETURN NULL
    if (uid == null || uid == '') return null;

    // CHECK IF CURRENT COURSE ID IS NULL, IF IT IS, RETURN NULL
    if (courseId == null || courseId == 0) return null;

    // GET ONE USER progress ON A COURSE FROM FIRESTORE AS A STREAM OF DOCUMENT SNAPSHOT
    return progressCollection
        .doc('${courseId}_$uid')
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return null; // Return null if the document doesn't exist
      } else {
        return _progressFromSnapshot(snapshot);
      }
    });
  }

  // THIS FUNCTION WILL UPDATE THE USER PROGRESS ON A COURSE IN THE DATABASE
  //WHEN THE USER START AND WHEN THE USER IS LEARNING A COURSE AND WHEN THE USER FINISHES A COURSE
  Future updateUserCourseProgress(
    String uid,
    int courseId,
    int currentIngingo,
    int totalIngingos,
  ) async {
    return await progressCollection.doc('${courseId}_$uid').set({
      'id': '${courseId}_$uid',
      'userId': uid,
      'courseId': courseId,
      'currentIngingo':
          currentIngingo > totalIngingos ? totalIngingos : currentIngingo,
      'totalIngingos': totalIngingos,
    });
  }
}
