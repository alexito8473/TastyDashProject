import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/view/letter.dart';
import 'package:tfgsaladillo/screen/view/login.dart';
import 'package:tfgsaladillo/screen/view/mapView.dart';

import '../widget/homeWidget.dart';
import 'settingView.dart';
import 'specialView.dart';

class HomePage extends StatefulWidget {
  Person? person;
  final Language lenguage;
  final BitmapDescriptor icon;
  final SharedPreferences prefs;
  final int initialPosition;
  Coin coin;
  List<Food> listFood;
  HomePage(
      {super.key,
      required this.person,
      required this.lenguage,
      required this.prefs,
      required this.icon,
      required this.coin,
      required this.initialPosition,
      required this.listFood});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int position = 0;
  bool changeIconPrice = true;

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
  final List<Coin> monedas = Coin.values;
  final List<CoolDropdownItem<String>> monedaDropdownItems = [];

  @override
  void initState() {
    position = widget.initialPosition;
    List<String> banderas = CrearListaBanderas();
    preSelectecLenguage = widget.lenguage.positionIdioma;
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

  void navigationLogin() {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: Login(
            idioma: widget.lenguage,
            prefs: widget.prefs,
            listaComida: widget.listFood,
          ),
        );
      },
    ));
  }

  void disconnected() {
    setState(() {
      widget.prefs.remove("Gmail");
      widget.person = null;
      position = 2;
    });
  }

  void changeCoin(String valor) {
    setState(() {
      widget.prefs.setString("SimboloMoneda", valor);
      widget.coin = devolverTipoMoneda(valor);
    });
  }

  void changePrice() {
    setState(() {
      changeIconPrice = !changeIconPrice;
    });
  }

  void changeLanguage(String valor) {
    setState(() {
      widget.lenguage.positionIdioma = int.parse(valor);
      widget.prefs.setInt("Idioma", int.parse(valor));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool controlSizeGnav = widget.person != null;
    Size size = MediaQuery.sizeOf(context);
    List<Widget> listPages = [
      Letter(
        listFood: widget.listFood,
        language: widget.lenguage,
        coin: widget.coin,
        person: widget.person,
      ),
      if (widget.person != null)
        EspecialView(
          size: size,
          idioma: widget.lenguage,
          listaComida: widget.listFood
              .where((element) =>
                  widget.person!.listFood!.contains(element.nombre))
              .toList(),
          monedaEnUso: widget.coin,
          cambioIconoPrecio: changeIconPrice,
          function: changePrice,
          person: widget.person!,
        ),
      Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: MapViewFood(icon: widget.icon),
      ),
      SettingView(
        funDesbloquearte: disconnected,
        funCambiarMoneda: changeCoin,
        funCambiarIdioma: changeLanguage,
        funNavegarLogin: navigationLogin,
        size: size,
        imagenBannerAjustes: imagenBannerAjustes,
        idioma: widget.lenguage,
        person: widget.person,
        lenguageDropdownController: lenguageDropdownController,
        lenguageDropdownItems: lenguageDropdownItems,
        monedaDropdownController: monedaDropdownController,
        monedaDropdownItems: monedaDropdownItems,
        monedas: monedas,
        monedEnUso: widget.coin,
      )
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
          switchInCurve: Curves.linear,
          duration: const Duration(milliseconds: 400),
          child: listPages[position]),
      bottomNavigationBar: Container(
          color: Colors.orange,
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01,
              horizontal:
                  controlSizeGnav ? size.width * 0.05 : size.width * 0.1),
          child: GNav(
            selectedIndex: position,
            tabBackgroundColor: Colors.white.withOpacity(0.8),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.015, horizontal: size.width * 0.04),
            gap: size.width * 0.01,
            onTabChange: (index) {
              setState(() {
                position = index;
              });
            },
            tabs: [
              GButton(
                  icon: Icons.fastfood,
                  text: widget.lenguage
                      .datosJson[widget.lenguage.positionIdioma]["Carta"]),
              if (widget.person != null)
                GButton(
                    icon: Icons.star,
                    text: widget.lenguage
                        .datosJson[widget.lenguage.positionIdioma]["Especial"]),
              GButton(
                  icon: Icons.map,
                  text: widget.lenguage
                      .datosJson[widget.lenguage.positionIdioma]["Mapa"]),
              GButton(
                  icon: Icons.settings,
                  text: widget.lenguage
                      .datosJson[widget.lenguage.positionIdioma]["Ajustes"]),
            ],
          )),
    );
  }
}
