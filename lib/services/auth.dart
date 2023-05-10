import 'package:firebase_auth/firebase_auth.dart';
import 'package:tegura/models/user.dart';

// CLASS FOR HANDLING AUTH SERVICES
class AuthService {
  // INSTANCE OF THE FIREBASE AUTHENTICATION
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // CREATE USER OBJECT BASED ON FIREBASE USER
  UserModel? _userFromFirebaseUser(User usr) {
    return usr != null ? UserModel(uid: usr.uid) : null;
  }

  // AUTH CHANGE USER STREAM
  Stream<UserModel?> get usr {
    return _auth
        .authStateChanges()
        .map((User? usr) => _userFromFirebaseUser(usr!));
  }


  // SIGN IN ANONYMOUSLY METHOD
  Future signInAnon() async {
    // ASYNC METHOD TO RETURN A FUTURE
    try {
      // SIGN IN ANONYMOUSLY
      UserCredential result = await _auth.signInAnonymously();

      // GET THE USER FROM THE RESULT
      User? user = result.user;

      // RETURN THE USER
      return _userFromFirebaseUser(user!);
    } catch (e) {
      // PRINT THE ERROR
      print(e.toString());

      // RETURN NULL
      return null;
    }
  }

  // SIGN IN WITH EMAIL AND PASSWORD METHOD

  // REGISTER WITH EMAIL AND PASSWORD METHOD

  // SIGN OUT METHOD
}
