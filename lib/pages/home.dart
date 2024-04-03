import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/pages/MapView.dart';
import 'package:tfgsaladillo/pages/Perfil.dart';
import 'package:tfgsaladillo/pages/SettingView.dart';
import 'package:tfgsaladillo/pages/carta.dart';
import 'package:tfgsaladillo/model/Person.dart';

class HomePage extends StatefulWidget {
  final Person person;
  final Idioma idioma;
  final SharedPreferences prefs;
  const HomePage(
      {super.key,
      required this.person,
      required this.idioma,
      required this.prefs});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int posicion = 0;
  static const keyLanguage = "key-language";
  @override
  Widget build(BuildContext context) {
    final int preSelectec = widget.idioma.positionIdioma;
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body:Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bannersuperior.jpg"),
                      fit: BoxFit.fill
                  )),
          child:posicion == 0
              ? Carta()
              : posicion == 1
                  ? MapViewFood()
                  : SingleChildScrollView(
            child:Container(
              width: double.infinity,
                child:Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width*0.1),
                      width:  size.width,
                      margin: EdgeInsets.only(top: size.height*0.07),
                      child:Text(widget.idioma
                          .datosJson[widget.idioma.positionIdioma]["MiCuenta"],style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                    ),
                        Container(
                          margin: EdgeInsets.only(left: size.width*0.1),
                          child: Column(
                            children: [
                              Container(
                                  margin:EdgeInsets.only(top: size.height*0.01) ,
                                width:size.width*0.9,
                                child:  Text(widget.idioma
                                    .datosJson[widget.idioma.positionIdioma]["Nombre"],style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.left,)
                              ),
                              SizedBox(
                                  width:size.width*0.9,
                                  child: Text(widget.person.nombre,style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left)
                              ),
                              Container(
                                  margin:EdgeInsets.only(top: size.height*0.01) ,
                                  width:size.width*0.9,
                                  child: const Text("E-mail",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.left)
                              ),
                              SizedBox(
                                  width:size.width*0.9,
                                  child: Text(widget.person.gmail,style: const TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left)
                              ),
                            ],
                          ),
                        ),

                    Container(
                        height: size.height*0.9,
                        margin: EdgeInsets.only(top: size.height*0.03),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width:size.width,
                                margin: EdgeInsets.only(top: size.height*0.04,left: size.width*0.1),
                                child: Text(widget.idioma
                                    .datosJson[widget.idioma.positionIdioma]["Ajustes"],style: TextStyle(fontSize: 30,color: Colors.white),textAlign: TextAlign.left,),
                              ),
                              Container(
                                width: size.width*0.7,
                                margin: EdgeInsets.only(top: size.height*0.05),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(40),

                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(widget.idioma
                                        .datosJson[widget.idioma.positionIdioma]["Idioma"],style: TextStyle(fontSize: 20)),
                                    DropdownButton(
                                      value: preSelectec,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 0,
                                          child: Text("Español"),
                                        ),
                                        DropdownMenuItem(
                                            value: 1, child: Text("English")),
                                      ],
                                      onChanged: (value) => {
                                        setState(() {
                                          widget.prefs.setInt("Idioma", value!);
                                          widget.idioma.positionIdioma = value!;
                                        }),
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                  ]

            )
          )
          )          ) ,

          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(0),
              color: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: GNav(
                tabBackgroundColor: Colors.white70,
                backgroundColor: Colors.orange,
                padding: EdgeInsets.all(15),
                gap: 12,
                onTabChange: (index) {
                  setState(() {
                    posicion = index;
                  });
                },
                tabs: [
                  GButton(
                      icon: Icons.fastfood,
                      text: widget.idioma
                          .datosJson[widget.idioma.positionIdioma]["Carta"],
                      hoverColor: Colors.amber),
                  GButton(
                      icon: Icons.map,
                      text: widget.idioma
                          .datosJson[widget.idioma.positionIdioma]["Mapa"],
                      hoverColor: Colors.amber),
                  GButton(
                      icon: Icons.settings,
                      text: widget.idioma
                          .datosJson[widget.idioma.positionIdioma]["Ajustes"],
                      hoverColor: Colors.amber),
                ],
              )),
        )
      ],
    );
  }
}
