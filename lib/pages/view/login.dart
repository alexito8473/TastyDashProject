import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/view/home.dart';
import 'package:tfgsaladillo/pages/view/register.dart';
import 'package:tfgsaladillo/services/AuthServices.dart';

import '../../model/Comida.dart';
import '../widget/genericWidget.dart';
import '../widget/loginWidget.dart';

class Login extends StatefulWidget {
  final Idioma idioma;
  final SharedPreferences prefs;
  final List<Comida> listaComida;
  const Login(
      {super.key,
      required this.idioma,
      required this.prefs,
      required this.listaComida});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool carga = false;
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Person person;

  void login() async {
    List listaReserva = [];
    DatabaseReference date = FirebaseDatabase.instance.ref();
    String gmail = _gmailController.text;
    String password = _passwordController.text;
    BitmapDescriptor icon;
    if (gmail.isNotEmpty || password.isNotEmpty) {
      setState(() {
        carga = true;
      });
    }
    if (await AuthService.sigIn(gmail, password)) {
      final snapshot = await date
          .child("Person/${gmail.trim().split("@")[0].toLowerCase()}/Nombre")
          .get();
      final listaComida = await date
          .child(
              "Person/${gmail.trim().split("@")[0].toLowerCase()}/listaComida")
          .get();
      if (listaComida.value is List<dynamic>) {
        listaReserva.addAll(listaComida.value as List<dynamic>);
      }
      person = Person(
          nombre: snapshot.value.toString(),
          gmail: gmail,
          pasword: password,
          listaComida: listaReserva);
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
                  monedaEnUso: devolverTipoMoneda(
                      widget.prefs.getString("SimboloMoneda")),
                  posicionInicial: 3,
                  listaComida: widget.listaComida,
                )),
        (route) => false,
      );
    } else {
      messageToCustomer(context, "Gmail y/o contraseña no son correctos", 15);
      setState(() {
        carga = false;
      });
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
                    login();
                  },
                  child: carga
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text(
                          widget.idioma.datosJson[widget.idioma.positionIdioma]
                              ["Iniciar_sesion"],
                          style: const TextStyle(fontSize: 20),
                        ),
                ),
              ),
              GestureDetector(
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
                          idioma: widget.idioma,
                          prefs: widget.prefs,
                          listaComida: widget.listaComida,
                        ),
                      );
                    },
                  ));
                },
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.28,
                        vertical: size.width * 0.01),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 2)),
                    ),
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
          floatingActionButton: const ButtonBack(),
        )
      ],
    );
  }
}
