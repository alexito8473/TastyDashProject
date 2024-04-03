import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/home.dart';
import 'package:tfgsaladillo/services/AuthServices.dart';

class InicioSesion extends StatefulWidget {
  final Idioma idioma;
  final SharedPreferences prefs;

  const InicioSesion({super.key, required this.idioma, required this.prefs});

  @override
  State<InicioSesion> createState() => _InicioSesion();
}

class _InicioSesion extends State<InicioSesion> {
  TextEditingController _gmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  DatabaseReference date = FirebaseDatabase.instance.ref();
  late Person person;

  @override
  void dispose() {
    _gmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    String gmail = _gmailController.text;
    String password = _passwordController.text;
    bool user = await authService.sigIn(gmail, password);
    if (user) {
      final snapshot = await date
          .child("Person/${gmail.trim().split("@")[0].toLowerCase()}/Nombre")
          .get();
      person = Person(
          nombre: snapshot.value.toString(), gmail: gmail, pasword: password);
      await widget.prefs.setString("Name", person.nombre);
      await widget.prefs.setString("Gmail", person.gmail);
      await widget.prefs.setString("Password", person.pasword);
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(person: person, idioma: widget.idioma, prefs: widget.prefs,)),
        (route) => false,
      );
    } else {
      MensajeAlCliente(context, "Gmail y/o contraseña no son correctos", 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Background(asset: "assets/images/start.jpg"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: EdgeInsets.only(
                top:
                    //200
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? size.height * 0.3
                        : 30),
            children: [
              const Titular(title: "Tasty Dash"),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  children: [
                    TextFieldMio(
                      controller: _gmailController,
                      sizeContext: size,
                      hint: "Gmail",
                      icono: Icons.email,
                      textType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                      obscureText: false,
                    ),
                    TextFieldMio(
                      controller: _passwordController,
                      sizeContext: size,
                      hint: "Contraseña",
                      icono: Icons.lock,
                      textType: TextInputType.name,
                      action: TextInputAction.none,
                      obscureText: true,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 20),
                      height: 55,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: FloatingActionButton(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                        onPressed: () {
                          login(context);
                        },
                        child: const Text(
                          "Iniciar sesión",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 165,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: 1))),
                      child: FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        child: const Text(
                          "Crear una cuenta",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              height: BorderSide.strokeAlignOutside,
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
