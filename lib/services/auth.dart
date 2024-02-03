import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:want_coffee/models/user.dart';
import 'package:want_coffee/services/database.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // ### 2    create user obj based on User from Firebase
  User? createUserObjFromFirebaseUser(auth.User? user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // ### 3    auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges().map(createUserObjFromFirebaseUser);
  }

  // ### 1   sign in with email & passowrd
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User? firebaseUser = result.user;

      User? user = createUserObjFromFirebaseUser(firebaseUser);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(user!.uid).updateUserData(
        '0',
        'new member',
        100,
      );
      return createUserObjFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
