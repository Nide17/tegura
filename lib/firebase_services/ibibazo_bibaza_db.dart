import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tegura/models/ibibazo_bibaza.dart';

class IbibazoBibazaService {
  // COLLECTIONS REFERENCE - FIRESTORE
  final CollectionReference ibibazoBibazaCollection =
      FirebaseFirestore.instance.collection('ibibazo_bibaza');

  // CONSTRUCTOR
  IbibazoBibazaService();

// #############################################################################
// MODELING DATA
// #############################################################################
  // GET ibibazoBibaza FROM A SNAPSHOT USING THE ibibazoBibaza MODEL - _ibibazoBibazaFromSnapshot
  List<IbibazoBibazaModel> _ibibazoBibazaFromSnapshot(
      QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      final question = data.containsKey('question') ? data['question'] : '';
      final answer = data.containsKey('answer') ? data['answer'] : '';

      return IbibazoBibazaModel(
        id: doc.id,
        question: question,
        answer: answer,
      );
    }).toList();
  }

  // GET ONE ibibazoBibaza FROM A SNAPSHOT USING THE ibibazoBibaza MODEL - _ibibazoBibazaFromSnapshot
  // FUNCTION CALLED EVERY TIME THE ibibazoBibaza DATA CHANGES
  IbibazoBibazaModel _ikibazoBibazaFromSnapshot(
      DocumentSnapshot documentSnapshot) {
    // GET THE DATA FROM THE SNAPSHOT
    final data = documentSnapshot.data() as Map<String, dynamic>;

    // CHECK IF THE FIELDS EXIST BEFORE ASSIGNING TO THE VARIABLE
    final id = documentSnapshot.id;
    final question = data.containsKey('question') ? data['question'] : '';
    final answer = data.containsKey('answer') ? data['answer'] : '';

    // RETURN A LIST OF ibibazoBibaza FROM THE SNAPSHOT
    return IbibazoBibazaModel(
      id: id,
      question: question,
      answer: answer,
    );
  }

// #############################################################################
// GET DATA
// #############################################################################
  // GET ALL ibibazoBibaza
  Stream<List<IbibazoBibazaModel>> get ibibazoBibaza {
    return ibibazoBibazaCollection.snapshots().map(_ibibazoBibazaFromSnapshot);
  }

  // GET ONE ibibazoBibaza
  Stream<IbibazoBibazaModel> getIbibazoBibaza(String id) {
    return ibibazoBibazaCollection
        .doc(id)
        .snapshots()
        .map(_ikibazoBibazaFromSnapshot);
  }
}
