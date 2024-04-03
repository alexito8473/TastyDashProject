import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/home.dart';
import 'package:tfgsaladillo/pages/login.dart';
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
    var d = const Duration(seconds: 2);
    Idioma idioma;
    String? nombre;
    String? gmail;
    String? password;
    Future.delayed(d, () async {
      datosJson = await leerListaJson(await rootBundle.loadString("Data/leng.json"));
      print(datosJson);
      prefs = await SharedPreferences.getInstance();
      int? posicionIdioma= prefs.getInt("Idioma");
      if(posicionIdioma==null){
        idioma = Idioma(datosJson: datosJson, positionIdioma: 0);
      }else{
        if(posicionIdioma>=0&&posicionIdioma<=1){
          idioma = Idioma(datosJson: datosJson, positionIdioma: posicionIdioma);
        }else{
          idioma = Idioma(datosJson: datosJson, positionIdioma: 0);
        }
      }
      nombre= prefs.getString("Name");
      gmail= prefs.getString("Gmail");
      password= prefs.getString("Password");
      if(nombre==null||gmail==null||password==null){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => InicioSesion(idioma: idioma, prefs: prefs,)),
                (route) => false);
      }else{
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage(person: Person(nombre:nombre!, pasword: password!, gmail: gmail!), idioma: idioma, prefs: prefs,)),
                (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Background(asset: "assets/images/mio.png"),
        const Align(
            alignment: AlignmentDirectional.bottomCenter,
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
                        fontSize: 27,
                        color: Colors.white),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    "By Alejandro Aguilar",
                    style: TextStyle(fontSize: 10, color: Colors.white),
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
            children:  [
              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 6,
              )
            ],
          ),
        ))
      ]),
    );
  }
}
