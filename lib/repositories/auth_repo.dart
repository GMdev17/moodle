import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodle/screens/auth/auth_page.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password, UserRole role) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
        "email": email,
        "role": role == UserRole.student ? "student" : "teacher",
      });
    } catch (e) {
      throw Exception("Error during sign-up: $e");
    }
  }

  Future<UserRole?> getUserRole(String uid) async {
    DocumentSnapshot doc =
        await _firebaseFirestore.collection("users").doc(uid).get();
    if (doc.exists) {
      String role = doc["role"];
      return role == "student" ? UserRole.student : UserRole.teacher;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
