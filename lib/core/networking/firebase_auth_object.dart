import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthObject {
  //SingleTon FirebaseAuth Object
  static final _firebaseInstance = _getFirebaseInstance();
  static FirebaseAuth get instance => _firebaseInstance;
  static FirebaseAuth _getFirebaseInstance() => FirebaseAuth.instance;
}
