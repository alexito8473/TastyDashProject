import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<bool> sigIn(String email, String password) async {
    bool exit=false;
    try {
      (await _auth.signInWithEmailAndPassword(
              email: email.trim(), password: password))
          .user;
      exit=true;
    } catch (e) {
      print("Error en el logeo");
      return exit;
    }
    return exit;
  }

    Future<UserCredential?> register(String email, String password) async {
    UserCredential? user;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password));
    } catch (e) {
      print("Error en el logeo");
    }
    return user;
  }
}
