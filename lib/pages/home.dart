import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/pages/MapView.dart';
import 'package:tfgsaladillo/pages/carta.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/login.dart';

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
  static List<Comida> listaDeComida = [
    Comida(
        nombre: 'BurguerMax',
        foto: 'assets/images/hamburguesa.jpg',
        descripcion: 'Nada malo',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPizza: false,
        isPescado: false,
        isSuchi: false),
    Comida(
        nombre: 'BurguerUltra',
        foto: 'assets/images/imagen.jpg',
        descripcion: 'Nada malo',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPizza: false,
        isPescado: false,
        isSuchi: false)
  ];
  @override
  Widget build(BuildContext context) {
    final int preSelectec = widget.idioma.positionIdioma;
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bannersuperior.jpg"),
                      fit: BoxFit.fill)
              ),
              child: posicion == 0
                  ? Carta(listaDeComida: listaDeComida,)
                  : posicion == 1
                      ? MapViewFood()
                      : SingleChildScrollView(
                          child: SizedBox(
                              width: size.width,
                              child: Column(children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.1),
                                  width: size.width,
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.07),
                                  child: Text(
                                    widget.idioma.datosJson[widget
                                        .idioma.positionIdioma]["MiCuenta"],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: size.width * 0.1),
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.01),
                                          width: size.width * 0.9,
                                          child: Text(
                                            widget.idioma.datosJson[widget
                                                .idioma
                                                .positionIdioma]["Nombre"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                            textAlign: TextAlign.left,
                                          )),
                                      SizedBox(
                                          width: size.width * 0.9,
                                          child: Text(widget.person.nombre,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.left)),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.01),
                                          width: size.width * 0.9,
                                          child: const Text("E-mail",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              textAlign: TextAlign.left)),
                                      Container(
                                          margin: EdgeInsets.only(
                                              bottom: size.height * 0.02),
                                          width: size.width * 0.9,
                                          child: Text(widget.person.gmail,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.left)),
                                      FloatingActionButton.extended(
                                          extendedIconLabelSpacing: 10,
                                          elevation: 30,
                                          backgroundColor: Colors.white70,
                                          icon: const Icon(
                                              FontAwesomeIcons.powerOff),
                                          onPressed: () {
                                            widget.prefs.remove("Name");
                                            widget.prefs.remove("Gmail");
                                            widget.prefs.remove("Password");
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InicioSesion(
                                                          idioma: widget.idioma,
                                                          prefs: widget.prefs)),
                                              (route) => false,
                                            );
                                          },
                                          label: Text(widget.idioma.datosJson[
                                                  widget.idioma.positionIdioma]
                                              ["Cerrar_sesion"]))
                                    ],
                                  ),
                                ),
                                Container(
                                    height: size.height * 0.9,
                                    margin: EdgeInsets.only(
                                        top: size.height * 0.02),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: size.width,
                                            margin: EdgeInsets.only(
                                                top: size.height * 0.04,
                                                left: size.width * 0.1),
                                            child: Text(
                                              widget.idioma.datosJson[widget
                                                  .idioma
                                                  .positionIdioma]["Ajustes"],
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.7,
                                            margin: EdgeInsets.only(
                                                top: size.height * 0.03,
                                                bottom: size.height * 0.02),
                                            decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                    widget.idioma.datosJson[
                                                            widget.idioma
                                                                .positionIdioma]
                                                        ["Idioma"],
                                                    style: const TextStyle(
                                                        fontSize: 21)),
                                                DropdownButton(
                                                  value: preSelectec,
                                                  items: const [
                                                    DropdownMenuItem(
                                                      value: 0,
                                                      child: Text("Español"),
                                                    ),
                                                    DropdownMenuItem(
                                                        value: 1,
                                                        child: Text("English")),
                                                  ],
                                                  onChanged: (value) => {
                                                    setState(() {
                                                      widget.prefs.setInt(
                                                          "Idioma", value!);
                                                      widget.idioma
                                                              .positionIdioma =
                                                          value;
                                                    }),
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          FloatingActionButton.extended(
                                              extendedIconLabelSpacing: 10,
                                              backgroundColor: Colors.white70,
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                            content:
                                                                SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              10),
                                                                  child: Text(
                                                                    widget.idioma
                                                                            .datosJson[
                                                                        widget
                                                                            .idioma
                                                                            .positionIdioma]["Politica"],
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20),
                                                                  )),
                                                              Text(
                                                                  widget.idioma.datosJson[widget
                                                                          .idioma
                                                                          .positionIdioma]
                                                                      [
                                                                      "Politica_Text1"],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                              Text(
                                                                  widget.idioma.datosJson[widget
                                                                          .idioma
                                                                          .positionIdioma]
                                                                      [
                                                                      "Politica_Text2"],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                              Text(
                                                                  widget.idioma.datosJson[widget
                                                                          .idioma
                                                                          .positionIdioma]
                                                                      [
                                                                      "Politica_Text3"],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                              Text(
                                                                  widget.idioma.datosJson[widget
                                                                          .idioma
                                                                          .positionIdioma]
                                                                      [
                                                                      "Politica_Text4"],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                              Text(
                                                                  widget.idioma.datosJson[widget
                                                                          .idioma
                                                                          .positionIdioma]
                                                                      [
                                                                      "Politica_Text5"],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                            ],
                                                          ),
                                                        )));
                                              },
                                              label: Text(
                                                  widget.idioma.datosJson[widget
                                                          .idioma
                                                          .positionIdioma]
                                                      ["Politica"],
                                                  style: const TextStyle(
                                                      fontSize: 18)))
                                        ],
                                      ),
                                    ))
                              ])))),
          bottomNavigationBar: Container(
              color: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: GNav(
                tabBackgroundColor: Colors.white70,
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.all(15),
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
                          .datosJson[widget.idioma.positionIdioma]["Carta"]),
                  GButton(
                      icon: Icons.map,
                      text: widget.idioma
                          .datosJson[widget.idioma.positionIdioma]["Mapa"]),
                  GButton(
                      icon: Icons.settings,
                      text: widget.idioma
                          .datosJson[widget.idioma.positionIdioma]["Ajustes"]),
                ],
              )),
        )
      ],
    );
  }
}
