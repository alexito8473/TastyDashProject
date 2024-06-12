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

import '../../utils/Constant.dart';
import 'letter.dart';
import 'login.dart';
import 'mapView.dart';
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
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _position = 0;
  bool _changeIconPrice = true;

  // Datos para realizar el lenguaje
  final _languageDropdownController = DropdownController();
  final List<String> _languages = ["Español", "English"];
  final List<CoolDropdownItem<String>> _languageDropdownItems = [];

  // Imagen para el mapa
  final ImageProvider imageBannerSettings =
      const AssetImage("assets/images/bannersuper.webp");

  // Datos para realizar la moneda
  final _coinDropdownController = DropdownController();
  final List<Coin> _coins = Coin.values;
  final List<CoolDropdownItem<String>> _coinDropdownItems = [];

  @override
  void initState() {
    _position = widget.initialPosition;
    List<String> flags = ["assets/Icons/Spain.svg", "assets/Icons/England.svg"];;
    for (var i = 0; i < _languages.length; i++) {
      _languageDropdownItems.add(
        CoolDropdownItem<String>(
            label: _languages[i],
            icon: SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(flags[i]),
            ),
            value: '$i'),
      );
    }
    for (var i = 0; i < _coins.length; i++) {
      _coinDropdownItems.add(
        CoolDropdownItem<String>(
            label: _coins[i].name.toLowerCase().replaceFirst(
                _coins[i].name.toLowerCase().substring(0, 1),
                _coins[i].name.substring(0, 1).toUpperCase()),
            value: _coins[i].symbol,
            icon: Text(
              _coins[i].symbol,
              style: const TextStyle(color: Colors.black),
            )),
      );
    }
    super.initState();
  }
  void _navigationToLogin() {
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

  void _disconnected() {
    setState(() {
      widget.prefs.remove(Constant.SHARED_PREFERENCE_MAIL);
      widget.person = null;
      _position = 2;
    });
  }

  void _changeCoin(String valor) {
    setState(() {
      widget.prefs.setString(Constant.SHARED_PREFERENCE_COIN, valor);
      widget.coin = Coin.returnTypeCoin(valor);
    });
  }

  void _changePrice() {
    setState(() {
      _changeIconPrice = !_changeIconPrice;
    });
  }

  void _changeLanguage(String valor) {
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
          changeIconPrice: _changeIconPrice,
          function: _changePrice,
          person: widget.person!,
        ),
      Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: MapViewFood(icon: widget.icon),
      ),
      SettingView(
        disconnected: _disconnected,
        changeCoin: _changeCoin,
        changeLanguage: _changeLanguage,
        navigationLogin: _navigationToLogin,
        size: size,
        imageBannerSettings: imageBannerSettings,
        language: widget.language,
        person: widget.person,
        languageDropdownController: _languageDropdownController,
        languageDropdownItems: _languageDropdownItems,
        coinDropdownController: _coinDropdownController,
        coinDropdownItems: _coinDropdownItems,
        coins: _coins,
        coin: widget.coin,
      )
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
        switchInCurve: Curves.linear,
        duration: const Duration(milliseconds: 400),
        child: listPages[_position],
      ),
      bottomNavigationBar: Container(
          color: Colors.orange,
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01,
              horizontal:
                  (widget.person != null) ? size.width * 0.05 : size.width * 0.1),
          child: GNav(
            selectedIndex: _position,
            tabBackgroundColor: Colors.white.withOpacity(0.8),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.015, horizontal: size.width * 0.04),
            gap: size.width * 0.01,
            onTabChange: (index) {
              setState(() {
                _position = index;
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
