import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<bool> sigInAuth(String email, String password) async {
    bool exit = false;
    try {
      (await _auth.signInWithEmailAndPassword(
              email: email.trim(), password: password))
          .user;
      exit = true;
    } catch (e) {
      if (kDebugMode) {
        print("Error en el logeo");
      }
    }
    return exit;
  }

  static Future<bool> registerAuth(String email, String password) async {
    bool exit = false;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      exit = true;
    } catch (e) {
      if (kDebugMode) {
        print("No se ha podido registrar");
      }
    }
    return exit;
  }
}
