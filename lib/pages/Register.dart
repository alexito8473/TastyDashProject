import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/Home.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/services/AuthServices.dart';

class Registrarse extends StatefulWidget {
  final Idioma idioma;
  final SharedPreferences prefs;
  const Registrarse({super.key, required this.idioma, required this.prefs});
  @override
  State<StatefulWidget> createState() => _Registrarse();
}

class _Registrarse extends State<Registrarse> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  late Person person;
  DatabaseReference date = FirebaseDatabase.instance.ref();
  int valueNumeric = 0;
  @override
  void dispose() {
    _gmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register(BuildContext context) async {
    String nombre = _nameController.text;
    String gmail = _gmailController.text;
    String password = _passwordController.text;
    BitmapDescriptor icon;
    bool user = await authService.register(gmail, password);
    if (user) {
      await date
          .child("Person/${gmail.trim().split("@")[0].toLowerCase()}")
          .set({"Nombre": nombre, "Gmail": gmail, "Password": password});
      person = Person(nombre: nombre, gmail: gmail, pasword: password);
      await widget.prefs.setString("Name", person.nombre);
      await widget.prefs.setString("Gmail", person.gmail);
      await widget.prefs.setString("Password", person.pasword);
      icon=await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "assets/images/ic_map.png");
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  person: person,
                  idioma: widget.idioma,
                  prefs: widget.prefs, icon: icon, monedEnUso: Moneda.DOLAR,
                )),
        (route) => false,
      );
    } else {
      MensajeAlCliente(context, "No existe el usuario", 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Background(asset: "assets/images/register.webp"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: size.height * 0.1),
                  child: Titular(
                      title:
                          widget.idioma.datosJson[widget.idioma.positionIdioma]
                              ["Registrarse"])),
              Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.05,
                      left: size.width * 0.1,
                      right: size.width * 0.1),
                  child: TextFieldMio(
                    hint: widget.idioma.datosJson[widget.idioma.positionIdioma]
                        ["Nombre"],
                    sizeContext: size,
                    textType: TextInputType.name,
                    icono: Icons.person,
                    controller: _nameController,
                    action: TextInputAction.next,
                    obscureText: false,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child:   TextFieldMio(
                  hint: "Email",
                  sizeContext: size,
                  textType: TextInputType.emailAddress,
                  icono: Icons.email,
                  controller: _gmailController,
                  action: TextInputAction.next,
                  obscureText: false,
                )
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child:  TextFieldMio(
                  controller: _passwordController,
                  sizeContext: size,
                  hint: widget.idioma.datosJson[widget.idioma.positionIdioma]
                  ["Contraseña"],
                  icono: Icons.lock,
                  textType: TextInputType.name,
                  action: TextInputAction.none,
                  obscureText: true,
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width*0.2,vertical: size.height*0.015),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: FloatingActionButton(
                  heroTag: "moverFloating",
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  onPressed: () {
                    register(context);
                  },
                  child: Text(
                    widget.idioma.datosJson[widget.idioma.positionIdioma]
                        ["Registrarse"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              heroTag: "textoToButton",
              backgroundColor: Colors.orange,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_backspace)),
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
