import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/MapView.dart';
import 'package:tfgsaladillo/pages/Carta.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/Login.dart';

import 'EspecialView.dart';
import 'SettingView.dart';

class HomePage extends StatefulWidget {
  Person? person;
  final Idioma idioma;
  final BitmapDescriptor icon;
  final SharedPreferences prefs;
  final int posicionInicial;
  Moneda monedaEnUso;
  HomePage(
      {super.key,
      required this.person,
      required this.idioma,
      required this.prefs,
      required this.icon,
      required this.monedaEnUso,
      required this.posicionInicial});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int posicion = 0;
  bool cambioIconoPrecio=true;
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
      posicion = 2;
    });
  }

  void CambiarMoneda(String valor) {
    setState(() {
      widget.prefs.setString("SimboloMoneda", valor);
      widget.monedaEnUso = devolverTipoMoneda(valor);
    });
  }

  void CambioPrecio(){
    setState(() {
      cambioIconoPrecio=!cambioIconoPrecio;
    });
  }

  void CambiarIdioma(String valor) {
    setState(() {
      widget.idioma.positionIdioma = int.parse(valor);
      widget.prefs.setInt("Idioma", int.parse(valor));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool controlTamanoGNav = widget.person != null;
    Size size = MediaQuery.of(context).size;
    List<Widget> listaPaginas = [
      Carta(
        listaDeComida: listaDeComida,
        idioma: widget.idioma,
        monedaEnUso: widget.monedaEnUso,
      ),
      if (widget.person != null)
        EspecialView(
          size: size,
          idioma: widget.idioma,
          listaComida: listaDeComida
              .where((element) =>
                  widget.person!.listaComida.contains(element.nombre))
              .toList(),
          monedaEnUso: widget.monedaEnUso, cambioIconoPrecio: cambioIconoPrecio, function: CambioPrecio,
        ),
      Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: MapViewFood(icon: widget.icon),
      ),
      SettingView(
        funDesbloquearte: Desloquearte,
        funCambiarMoneda: CambiarMoneda,
        funCambiarIdioma: CambiarIdioma,
        funNavegarLogin: NavegarLogin,
        size: size,
        imagenBannerAjustes: imagenBannerAjustes,
        idioma: widget.idioma,
        person: widget.person,
        lenguageDropdownController: lenguageDropdownController,
        lenguageDropdownItems: lenguageDropdownItems,
        monedaDropdownController: monedaDropdownController,
        monedaDropdownItems: monedaDropdownItems,
        monedas: monedas,
        monedEnUso: widget.monedaEnUso,
      )
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
          switchInCurve: Curves.linear,
          duration: const Duration(milliseconds: 400),
          child: listaPaginas[posicion]),
      bottomNavigationBar: Container(
          color: Colors.orange,
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01,
              horizontal:
                  controlTamanoGNav ? size.width * 0.05 : size.width * 0.1),
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
              if (widget.person != null)
                GButton(
                    icon: Icons.star,
                    text: widget.idioma.datosJson[widget.idioma.positionIdioma]
                        ["Especial"]),
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
