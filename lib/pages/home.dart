import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/pages/MapView.dart';
import 'package:tfgsaladillo/pages/carta.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/login.dart';
class HomePage extends StatefulWidget {
  final Person person;
  final Idioma idioma;
  final BitmapDescriptor icon;
  final SharedPreferences prefs;
  const HomePage(
      {super.key,
      required this.person,
      required this.idioma,
      required this.prefs,
        required this.icon});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int posicion = 0;
  final lenguageDropdownController = DropdownController();
  List<String> lenguage = ["Español", "English"];
  List<CoolDropdownItem<String>> lenguageDropdownItems = [];
  ImageProvider imagenMia = const AssetImage("assets/images/bannersuper.webp");
  late final int preSelectec;
  static List<Comida> listaDeComida = CrearListaDeComida();
  @override
  void initState() {
    preSelectec = widget.idioma.positionIdioma;
    for (var i = 0; i < lenguage.length; i++) {
      lenguageDropdownItems.add(
        CoolDropdownItem<String>(
            label: lenguage[i],
            icon: SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(
                  "assets/Icons/Spain.svg"
              ),
            ),
            value: '$i'),
      );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: posicion == 0
          ? Carta(listaDeComida: listaDeComida)
          : posicion == 1
              ? MapViewFood(icon: widget.icon)
              : Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image:
                          DecorationImage(image: imagenMia, fit: BoxFit.fill)),
                  child: SingleChildScrollView(
                      child: SizedBox(
                          width: size.width,
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.1,top: size.height * 0.07),
                              width: size.width,
                              child: Text(
                                widget.idioma
                                        .datosJson[widget.idioma.positionIdioma]
                                    ["MiCuenta"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: size.width * 0.1),
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.01),
                                      width: size.width * 0.9,
                                      child: Text(
                                        widget.idioma.datosJson[widget
                                            .idioma.positionIdioma]["Nombre"],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
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
                                      backgroundColor: Colors.white,
                                      icon: const Icon(Icons.logout),
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
                                      label:Container(
                                        width: size.width*0.27,
                                        alignment: Alignment.center,
                                        child: Text(widget.idioma.datosJson[widget
                                            .idioma
                                            .positionIdioma]["Cerrar_sesion"],style: const TextStyle(color: Colors.black,fontSize: 15),)
                                      )

                  )
                                ],
                              ),
                            ),
                            Container(
                                height: size.height * 0.9,
                                margin:
                                    EdgeInsets.only(top: size.height * 0.02),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: size.width,
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.04,
                                            left: size.width * 0.1),
                                        child: Text(
                                          widget.idioma.datosJson[widget.idioma
                                              .positionIdioma]["Ajustes"],
                                          style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.white)
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.7,
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.03,
                                            bottom: size.height * 0.02),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child:  Text(
                                                  widget.idioma.datosJson[widget
                                                      .idioma
                                                      .positionIdioma]["Idioma"],
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ),
                                            Center(
                                              child: CoolDropdown<String>(
                                                controller: lenguageDropdownController,
                                                dropdownList: lenguageDropdownItems,
                                                defaultItem: lenguageDropdownItems[preSelectec],
                                                onChange: (value) => {
                                                  setState(() {
                                                    widget.prefs.setInt("Idioma",  int.parse(value));
                                                    widget.idioma.positionIdioma = int.parse(value);
                                                  }),
                                                },
                                                resultOptions: const ResultOptions(
                                                  width: 100,
                                                  render: ResultRender.label,
                                                  openBoxDecoration: BoxDecoration(
                                                    color: Colors.white
                                                ),
                                                  icon: SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child: CustomPaint(
                                                      painter: DropdownArrowPainter(
                                                          color: Colors.orange,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                dropdownOptions: const DropdownOptions(
                                                  width: 130,
                                                ),
                                                dropdownItemOptions: const DropdownItemOptions(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  selectedBoxDecoration: BoxDecoration(
                                                    color: Color(0XFFEFFAF0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FloatingActionButton.extended(
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                        content: PoliticaTexto(
                                                            idioma: widget
                                                                .idioma)));
                                          },
                                          label: Container(
                                            width: size.width*0.5, alignment: Alignment.center,
                                            child: Text(
                                                widget.idioma.datosJson[widget
                                                    .idioma
                                                    .positionIdioma]["Politica"],
                                                style: const TextStyle(
                                                    fontSize: 21,color: Colors.black)))
                                          )
                                    ],
                                  ),
                                ))
                          ]))),
                ),
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
                  text: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["Carta"]),
              GButton(
                  icon: Icons.map,
                  text: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["Mapa"]),
              GButton(
                  icon: Icons.settings,
                  text: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["Ajustes"]),
            ],
          )),
    );
  }
}

class PoliticaTexto extends StatelessWidget {
  final Idioma idioma;
  const PoliticaTexto({super.key, required this.idioma});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                idioma.datosJson[idioma.positionIdioma]["Politica"],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text1"],
              style: const TextStyle(fontSize: 12)),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text2"],
              style: const TextStyle(fontSize: 12)),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text3"],
              style: const TextStyle(fontSize: 12)),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text4"],
              style: const TextStyle(fontSize: 12)),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text5"],
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
