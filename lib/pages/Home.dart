import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/ChatAi.dart';
import 'package:tfgsaladillo/pages/MapView.dart';
import 'package:tfgsaladillo/pages/Carta.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/Login.dart';

class HomePage extends StatefulWidget {
  Person? person;
  final Idioma idioma;
  final BitmapDescriptor icon;
  final SharedPreferences prefs;
  final int posicionInicial;
  Moneda monedEnUso;
  HomePage(
      {super.key,
      required this.person,
      required this.idioma,
      required this.prefs,
      required this.icon,
      required this.monedEnUso,
      required this.posicionInicial});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int posicion = 0;
  // Lista de la comida
  static List<Comida> listaDeComida = CrearListaDeComida();

  // Datos para realizar el lenguaje
  late int preSelectecLenguage;
  final lenguageDropdownController = DropdownController();
  final List<String> lenguage = CrearListaPaises();
  final List<CoolDropdownItem<String>> lenguageDropdownItems = [];

  // Imagen para el mapa
  final ImageProvider imagenBannerAjustes =
      const AssetImage("assets/images/bannersuper.webp");

  // Datos para realizar la moneda
  final monedaDropdownController = DropdownController();
  final List<Moneda> monedas = Moneda.values;
  final List<CoolDropdownItem<String>> monedaDropdownItems = [];

  @override
  void initState() {
    posicion = widget.posicionInicial;
    List<String> banderas = CrearListaBanderas();
    preSelectecLenguage = widget.idioma.positionIdioma;
    for (var i = 0; i < lenguage.length; i++) {
      lenguageDropdownItems.add(
        CoolDropdownItem<String>(
            label: lenguage[i],
            icon: SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(banderas[i]),
            ),
            value: '$i'),
      );
    }
    for (var i = 0; i < monedas.length; i++) {
      monedaDropdownItems.add(
        CoolDropdownItem<String>(
            label: monedas[i].name.toLowerCase().replaceFirst(
                monedas[i].name.toLowerCase().substring(0, 1),
                monedas[i].name.substring(0, 1).toUpperCase()),
            value: monedas[i].simbolo,
            icon: Text(
              monedas[i].simbolo,
              style: const TextStyle(color: Colors.black),
            )),
      );
    }
    super.initState();
  }

  void NavegarLogin() {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: InicioSesion(idioma: widget.idioma, prefs: widget.prefs),
        );
      },
    ));
  }

  void Desloquearte() {
    setState(() {
      widget.prefs.remove("Name");
      widget.prefs.remove("Gmail");
      widget.prefs.remove("Password");
      widget.person = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
        switchInCurve: Curves.linear,
        duration: const Duration(milliseconds: 400),
        child: posicion == 0
            ? Carta(
                listaDeComida: listaDeComida,
                idioma: widget.idioma,
                monedaEnUso: widget.monedEnUso,
              )
            : posicion == 1
                ? Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white,
                    child: MapViewFood(icon: widget.icon),
                  )
                : Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: imagenBannerAjustes,
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.darken))),
                    child: ListView(children: [
                      TituloPageSetting(
                          size:size,
                          title:widget.idioma.datosJson[widget.idioma.positionIdioma]
                              ["MiCuenta"]),
                      if (widget.person != null)
                        InformacionUsuarioSetting(
                            size: size,
                            title: widget.idioma
                                    .datosJson[widget.idioma.positionIdioma]
                                ["Nombre"],
                            subtitle: widget.person!.nombre),
                      if (widget.person != null)
                        InformacionUsuarioSetting(
                            size: size,
                            title: "E-mail",
                            subtitle: widget.person!.gmail),
                      widget.person != null
                          ? ContaninerButtonFunction(
                              size: size,
                              functionCall: Desloquearte,
                              titulo: widget.idioma
                                      .datosJson[widget.idioma.positionIdioma]
                                  ["Cerrar_sesion"])
                          : ContaninerButtonFunction(
                              size: size,
                              functionCall: NavegarLogin,
                              titulo: "Iniciar sesión"),
                      Container(
                        height: size.height * 0.9,
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Column(
                          children: [
                            TituloPageSetting(
                                size:size,
                                title:  widget.idioma
                                        .datosJson[widget.idioma.positionIdioma]
                                    ["MiCuenta"]),
                            Container(
                              width: size.width * 0.7,
                              height: size.height * 0.06,
                              margin: EdgeInsets.only(
                                  top: size.height * 0.03,
                                  bottom: size.height * 0.02),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 100,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.idioma.datosJson[widget
                                          .idioma.positionIdioma]["Idioma"],
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  CoolDropdown<String>(
                                    dropdownTriangleOptions:
                                        const DropdownTriangleOptions(
                                            borderRadius: 0,
                                            align: DropdownTriangleAlign.center,
                                            width: 0),
                                    controller: lenguageDropdownController,
                                    dropdownList: lenguageDropdownItems,
                                    defaultItem: lenguageDropdownItems[
                                        widget.idioma.positionIdioma],
                                    onChange: (value) => {
                                      setState(() {
                                        widget.idioma.positionIdioma =
                                            int.parse(value);
                                        widget.prefs
                                            .setInt("Idioma", int.parse(value));
                                      }),
                                    },
                                    resultOptions: const ResultOptions(
                                      width: 100,
                                      render: ResultRender.label,
                                      openBoxDecoration:
                                          BoxDecoration(color: Colors.white),
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
                                    dropdownItemOptions:
                                        styleDropdownItemOptions(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: size.width * 0.7,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(
                                    width: 105,
                                    child: Text("Moneda",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                  Center(
                                    child: CoolDropdown<String>(
                                      controller: monedaDropdownController,
                                      dropdownList: monedaDropdownItems,
                                      defaultItem: monedaDropdownItems[
                                          monedas.indexOf(widget.monedEnUso)],
                                      onChange: (value) => {
                                        setState(() {
                                          widget.prefs.setString(
                                              "SimboloMoneda", value);
                                          widget.monedEnUso =
                                              devolverTipoMoneda(value);
                                        })
                                      },
                                      resultOptions: const ResultOptions(
                                        width: 90,
                                        render: ResultRender.label,
                                        openBoxDecoration:
                                            BoxDecoration(color: Colors.white),
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
                                          color: Colors.white,
                                          width: 100,
                                          align: DropdownAlign.center),
                                      dropdownItemOptions:
                                          styleDropdownItemOptions(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BotonTerminosDeUso(
                              idioma: widget.idioma,
                              size: size,
                            ),
                            /*
                            FloatingActionButton(
                              heroTag: null,
                              onPressed: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  reverseTransitionDuration:
                                      const Duration(milliseconds: 500),
                                  barrierColor: Colors.black54,
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: ChatAi(),
                                    );
                                  },
                                ));
                              },
                            )
                            */
                          ],
                        ),
                      )
                    ]),
                  ),
      ),
      bottomNavigationBar: Container(
          color: Colors.orange,
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01, horizontal: size.width * 0.1),
          child: GNav(
            selectedIndex: posicion,
            tabBackgroundColor: Colors.white.withOpacity(0.8),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.015, horizontal: size.width * 0.04),
            gap: size.width * 0.01,
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

DropdownItemOptions styleDropdownItemOptions() {
  return const DropdownItemOptions(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textStyle: TextStyle(color: Colors.black),
    selectedTextStyle: TextStyle(color: Colors.black),
    selectedBoxDecoration: BoxDecoration(
      color: Colors.black38,
    ),
  );
}

class BotonTerminosDeUso extends StatelessWidget {
  final Idioma idioma;
  final Size size;
  const BotonTerminosDeUso(
      {super.key, required this.idioma, required this.size});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              barrierDismissible: false,
              barrierColor: Colors.black.withOpacity(0.6),
              useSafeArea: false,
              context: context,
              builder: (context) =>
                  AlertDialog(content: PoliticaTexto(idioma: idioma)));
        },
        child: Container(
            width: size.width * 0.7,
            height: size.height * 0.06,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: size.height * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(idioma.datosJson[idioma.positionIdioma]["Politica"],
                style: const TextStyle(fontSize: 21, color: Colors.black))));
  }
}

class PoliticaTexto extends StatelessWidget {
  final Idioma idioma;
  const PoliticaTexto({super.key, required this.idioma});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width * .8,
        height: size.height * .7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: size.width * .1,
                      height: size.height * .05,
                      child: const Icon(Icons.keyboard_backspace),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: size.width * .05),
                      child: Text(
                        idioma.datosJson[idioma.positionIdioma]["Politica"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ))
                ]),
              ),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text1"],
                  style: const TextStyle(fontSize: 18)),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text2"],
                  style: const TextStyle(fontSize: 18)),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text3"],
                  style: const TextStyle(fontSize: 18)),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text4"],
                  style: const TextStyle(fontSize: 18)),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text5"],
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        ));
  }
}

class TituloPageSetting extends StatelessWidget {
  final Size size;
  final String title;
  TituloPageSetting({super.key, required this.size, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.09, top: size.height * 0.05),
      width: size.width,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class InformacionUsuarioSetting extends StatelessWidget {
  final Size size;
  final String title;
  final String subtitle;
  InformacionUsuarioSetting(
      {super.key,
      required this.size,
      required this.title,
      required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.01),
        width: size.width,
        child: ListTile(
          textColor: Colors.white,
          title: Text(title,  style: const TextStyle(color: Colors.orange, fontSize: 25)),
          subtitle: AutoSizeText(
            maxLines: 1,
            subtitle,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20),
          ),
        ));
  }
}

class ContaninerButtonFunction extends StatelessWidget {
  final Size size;
  final Function functionCall;
  final String titulo;
  const ContaninerButtonFunction(
      {super.key, required this.size, required this.functionCall, required this.titulo});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => functionCall(),
      child: Container(
          width: size.width,
          height: size.height * 0.06,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.25,vertical:size.height * 0.02),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: AutoSizeText(
            titulo,
            style: const TextStyle(color: Colors.black, fontSize: 20),
            maxLines: 1,
          )),
    );
  }
}
