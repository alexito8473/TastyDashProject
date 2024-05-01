import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/Home.dart';
import 'package:tfgsaladillo/pages/Register.dart';
import 'package:tfgsaladillo/services/AuthServices.dart';

class InicioSesion extends StatefulWidget {
  final Idioma idioma;
  final SharedPreferences prefs;
  const InicioSesion({super.key, required this.idioma, required this.prefs});
  @override
  State<InicioSesion> createState() => _InicioSesion();
}

class _InicioSesion extends State<InicioSesion> {
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  DatabaseReference date = FirebaseDatabase.instance.ref();
  late Person person;

  void login(BuildContext context) async {
    String gmail = _gmailController.text;
    String password = _passwordController.text;
    bool user = await authService.sigIn(gmail, password);
    BitmapDescriptor icon;
    if (user) {
      final snapshot = await date
          .child("Person/${gmail.trim().split("@")[0].toLowerCase()}/Nombre")
          .get();
      person = Person(
          nombre: snapshot.value.toString(), gmail: gmail, pasword: password);
      await widget.prefs.setString("Name", person.nombre);
      await widget.prefs.setString("Gmail", person.gmail);
      await widget.prefs.setString("Password", person.pasword);
      icon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), "assets/images/ic_map.webp");
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  person: person,
                  idioma: widget.idioma,
                  prefs: widget.prefs,
                  icon: icon,
                  monedEnUso: devolverTipoMoneda(
                      widget.prefs.getString("SimboloMoneda")),
                )),
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
        const Background(asset: "assets/images/start.webp"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.1, bottom: size.height * 0.05),
                  child: const Titular(title: "Tasty Dash")),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: TextFieldMio(
                    controller: _gmailController,
                    sizeContext: size,
                    hint: "Email",
                    icono: Icons.email,
                    textType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    obscureText: false,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: TextFieldMio(
                    controller: _passwordController,
                    sizeContext: size,
                    hint: widget.idioma.datosJson[widget.idioma.positionIdioma]
                        ["Contraseña"],
                    icono: Icons.lock,
                    textType: TextInputType.name,
                    action: TextInputAction.none,
                    obscureText: true,
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.2,
                    vertical: size.height * 0.015),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: FloatingActionButton(
                  heroTag: "moverFloating",
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  onPressed: () {
                    login(context);
                  },
                  child: Text(
                    widget.idioma.datosJson[widget.idioma.positionIdioma]
                        ["Iniciar_sesion"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 5),
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.28, vertical: size.width * 0.01),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border:
                      Border(bottom: BorderSide(color: Colors.white, width: 2)),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 1100),
                        reverseTransitionDuration:
                            const Duration(milliseconds: 700),
                        barrierColor: Colors.black,
                        opaque: true,
                        barrierDismissible: true,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: Registrarse(
                                idioma: widget.idioma, prefs: widget.prefs),
                          );
                        },
                      ));
                    },
                    child: Text(
                      widget.idioma.datosJson[widget.idioma.positionIdioma]
                          ["Crear_una_cuenta"],
                      style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          height: BorderSide.strokeAlignOutside,
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}

class Titular extends StatelessWidget {
  final String title;
  const Titular({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40)));
  }
}
