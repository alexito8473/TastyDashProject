import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
class AuthService {
  static final _auth = FirebaseAuth.instance;

  // Sign in user with email and password
  static Future<bool> signInAuth(String email, String password) async {
    bool success = false;
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      success = true;
    } catch (e) {
      if (kDebugMode) {
        print("Error logging in: $e");
      }
    }
    return success;
  }

  // Register user with email and password
  static Future<bool> registerAuth(String email, String password) async {
    bool success = false;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      success = true;
    } catch (e) {
      if (kDebugMode) {
        print("Error registering user: $e");
      }
    }
    return success;
  }
}

