import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // REGISTER

  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {

    try {

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'role': role,
        'createdAt': Timestamp.now(),
      });

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;

    } catch (e) {

      return e.toString();
    }
  }

  // LOGIN

  Future<String?> login({
    required String email,
    required String password,
  }) async {

    try {

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;

    } catch (e) {

      return e.toString();
    }
  }

  // LOGOUT

  Future<void> logout() async {
    await _auth.signOut();
  }

  // CURRENT USER

  User? get currentUser => _auth.currentUser;
}
