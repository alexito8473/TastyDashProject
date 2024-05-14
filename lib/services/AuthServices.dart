import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<bool> sigIn(String email, String password) async {
    bool exit = false;
    try {
      (await _auth.signInWithEmailAndPassword(
              email: email.trim(), password: password))
          .user;
      exit = true;
    } catch (e) {
      print("Error en el logeo");
      return exit;
    }
    return exit;
  }

  static Future<bool> register(String email, String password) async {
    bool exit = false;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      exit = true;
    } catch (e) {
      print("No se ha podido registrar");
    }
    return exit;
  }
}
