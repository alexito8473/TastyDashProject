import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/view/letter.dart';
import 'package:tfgsaladillo/screen/view/login.dart';
import 'package:tfgsaladillo/screen/view/mapView.dart';

import '../../utils/Constant.dart';
import 'settingView.dart';
import 'specialView.dart';

class HomePage extends StatefulWidget {
  Person? person;
  final Language language;
  final BitmapDescriptor icon;
  final SharedPreferences prefs;
  final int initialPosition;
  Coin coin;
  List<Food> listFood;

  HomePage(
      {super.key,
      required this.person,
      required this.language,
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
  late int preSelectedLanguage;
  final languageDropdownController = DropdownController();
  final List<String> language = ["Español", "English"];
  final List<CoolDropdownItem<String>> languageDropdownItems = [];

  // Imagen para el mapa
  final ImageProvider imageBannerSettings =
      const AssetImage("assets/images/bannersuper.webp");

  // Datos para realizar la moneda
  final coinDropdownController = DropdownController();
  final List<Coin> coins = Coin.values;
  final List<CoolDropdownItem<String>> monedaDropdownItems = [];

  @override
  void initState() {
    position = widget.initialPosition;
    List<String> flags = ["assets/Icons/Spain.svg", "assets/Icons/England.svg"];;
    preSelectedLanguage = widget.language.positionLanguage;
    for (var i = 0; i < language.length; i++) {
      languageDropdownItems.add(
        CoolDropdownItem<String>(
            label: language[i],
            icon: SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(flags[i]),
            ),
            value: '$i'),
      );
    }
    for (var i = 0; i < coins.length; i++) {
      monedaDropdownItems.add(
        CoolDropdownItem<String>(
            label: coins[i].name.toLowerCase().replaceFirst(
                coins[i].name.toLowerCase().substring(0, 1),
                coins[i].name.substring(0, 1).toUpperCase()),
            value: coins[i].symbol,
            icon: Text(
              coins[i].symbol,
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
            language: widget.language,
            prefs: widget.prefs,
            listFood: widget.listFood,
          ),
        );
      },
    ));
  }

  void disconnected() {
    setState(() {
      widget.prefs.remove(Constant.SharedPreferences_MAIL);
      widget.person = null;
      position = 2;
    });
  }

  void changeCoin(String valor) {
    setState(() {
      widget.prefs.setString(Constant.SHARED_PREFERENCE_COIN, valor);
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
      widget.language.positionLanguage = int.parse(valor);
      widget.prefs
          .setInt(Constant.SHARED_PREFERENCE_LANGUAGE, int.parse(valor));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    List<Widget> listPages = [
      Letter(
        listFood: widget.listFood,
        language: widget.language,
        coin: widget.coin,
        person: widget.person,
      ),
      if (widget.person != null)
        SpecialView(
          size: size,
          language: widget.language,
          listFood: widget.listFood
              .where(
                  (element) => widget.person!.listFood!.contains(element.name))
              .toList(),
          coin: widget.coin,
          changeIconPrice: changeIconPrice,
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
        disconnected: disconnected,
        changeCoin: changeCoin,
        changeLanguage: changeLanguage,
        navigationLogin: navigationLogin,
        size: size,
        imageBannerSettings: imageBannerSettings,
        language: widget.language,
        person: widget.person,
        languageDropdownController: languageDropdownController,
        languageDropdownItems: languageDropdownItems,
        coinDropdownController: coinDropdownController,
        coinDropdownItems: monedaDropdownItems,
        coins: coins,
        coin: widget.coin,
      )
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
        switchInCurve: Curves.linear,
        duration: const Duration(milliseconds: 400),
        child: listPages[position],
      ),
      bottomNavigationBar: Container(
          color: Colors.orange,
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01,
              horizontal:
                  (widget.person != null) ? size.width * 0.05 : size.width * 0.1),
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
                  text: widget.language
                      .dataJson[widget.language.positionLanguage]["Carta"]),
              if (widget.person != null)
                GButton(
                    icon: Icons.star,
                    text: widget
                            .language.dataJson[widget.language.positionLanguage]
                        ["Especial"]),
              GButton(
                  icon: Icons.map,
                  text: widget.language
                      .dataJson[widget.language.positionLanguage]["Mapa"]),
              GButton(
                  icon: Icons.settings,
                  text: widget.language
                      .dataJson[widget.language.positionLanguage]["Ajustes"]),
            ],
          )),
    );
  }
}
