import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tegura/models/isomo.dart';

class IsomoService {
  // COLLECTIONS REFERENCE - FIRESTORE
  final CollectionReference amasomoCollection =
      FirebaseFirestore.instance.collection('amasomo');

  // CONSTRUCTOR
  IsomoService();

  // GET AMASOMO FROM A SNAPSHOT USING THE ISOMO MODEL - _amasomoFromSnapshot
  // FUNCTION CALLED EVERY TIME THE AMASOMO DATA CHANGES
  List<IsomoModel> _amasomoFromSnapshot(QuerySnapshot querySnapshot) {
    // GET THE DATA FROM THE SNAPSHOT
    return querySnapshot.docs.map((doc) {
      // GET THE DATA FROM THE SNAPSHOT
      final data = doc.data() as Map<String, dynamic>;

      // CHECK IF THE FIELDS EXISTS BEFORE ASSIGNING IT TO THE VARIABLE
      final id = data.containsKey('id') ? data['id'] : '';
      final title = data.containsKey('title') ? data['title'] : '';
      final description =
          data.containsKey('description') ? data['description'] : '';
      final introText = data.containsKey('introText') ? data['introText'] : '';
      final conclusion = data.containsKey('conclusion') ? data['conclusion'] : '';

      // RETURN A LIST OF AMASOMO FROM THE SNAPSHOT
      return IsomoModel(
        // AMASOMO DATA - FIELDS
        id: id,
        title: title,
        description: description,
        introText: introText,
        conclusion: conclusion,
      );
    }).toList();
  }

  // GET AMASOMO STREAM
  Stream<List<IsomoModel?>>? getAllAmasomo(String? uid) {
    // CHECK IF CURRENT USER UID IS NULL, IF IT IS, RETURN NULL
    if (uid == null) return null;

    // GET ALL amasomo FROM FIRESTORE AS A STREAM OF DOCUMENT SNAPSHOT
    return amasomoCollection.snapshots().map(_amasomoFromSnapshot);
  }

}
