import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/view/home.dart';

import '../widget/genericWidget.dart';
import '../widget/homeWidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  late final SharedPreferences prefs;
  late List<dynamic> datosJson;

  @override
  void initState() {
    super.initState();
    DatabaseReference date = FirebaseDatabase.instance.ref();
    Idioma idioma;
    Person? person;
    String? nombre;
    BitmapDescriptor icon;
    String? gmail;
    String? password;
    int? posicionIdioma;
    Future.delayed(const Duration(milliseconds: 800), () async {
      await precacheImage(
          const AssetImage('assets/images/bannersuper.webp'), context);
      await precacheImage(
          const AssetImage("assets/images/bannerFiltros.webp"), context);
      await precacheImage(
          const AssetImage("assets/images/bannerCarne.webp"), context);
      await precacheImage(
          const AssetImage("assets/images/fondoSuelo.webp"), context);
      datosJson =
          await leerListaJson(await rootBundle.loadString("Data/leng.json"));
      prefs = await SharedPreferences.getInstance();
      posicionIdioma = prefs.getInt("Idioma");
      if (posicionIdioma == null) {
        idioma = Idioma(datosJson: datosJson, positionIdioma: 0);
      } else {
        if (posicionIdioma! >= 0 && posicionIdioma! <= 1) {
          idioma =
              Idioma(datosJson: datosJson, positionIdioma: posicionIdioma!);
        } else {
          idioma = Idioma(datosJson: datosJson, positionIdioma: 0);
        }
      }
      nombre = prefs.getString("Name");
      gmail = prefs.getString("Gmail");
      password = prefs.getString("Password");
      if (nombre == null || gmail == null || password == null) {
        person = null;
        prefs.remove("Name");
        prefs.remove("Gmail");
        prefs.remove("Password");
      } else {
        final nombre = await date
            .child("Person/${gmail?.trim().split("@")[0].toLowerCase()}/Nombre")
            .get();
        final password = await date
            .child(
                "Person/${gmail?.trim().split("@")[0].toLowerCase()}/Password")
            .get();
        final listaComida = await date
            .child(
                "Person/${gmail?.trim().split("@")[0].toLowerCase()}/listaComida")
            .get();
        List<dynamic> listaReserva = [];
        listaReserva.addAll(listaComida.value as List<dynamic>);
        person = Person(
            nombre: nombre.value.toString(),
            pasword: password.value.toString(),
            gmail: gmail!,
            listaComida: listaComida.value == null ? [] : listaReserva);
      }
      icon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), "assets/images/ic_map.webp");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    person: person,
                    idioma: idioma,
                    prefs: prefs,
                    icon: icon,
                    monedaEnUso:
                        devolverTipoMoneda(prefs.getString("SimboloMoneda")),
                    posicionInicial: 0,
                  )),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Background(asset: "assets/images/screen.webp"),
        const Center(
            child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Tasty Dash",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
                textAlign: TextAlign.end,
              ),
              Text(
                "By Alejandro Aguilar",
                style: TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.end,
              )
            ],
          ),
        )),
        Center(
            child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
          child: const Column(
            children: [
              CircularProgressIndicator(
                color: Colors.white,
                strokeAlign: 1.5,
                strokeWidth: 8,
              )
            ],
          ),
        ))
      ]),
    );
  }
}
