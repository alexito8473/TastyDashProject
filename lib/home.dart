import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tfgsaladillo/MapView.dart';
import 'package:tfgsaladillo/Perfil.dart';
import 'package:tfgsaladillo/SettingView.dart';
import 'package:tfgsaladillo/carta.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int posicion = 0;
  List<Widget> listaVisual = [Person(), Carta(), MapViewFood(), SettingView()];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: listaVisual[posicion],
          bottomNavigationBar: Container(
            color: Colors.orange,
            padding: EdgeInsets.all(8),
              child: GNav(
            tabBackgroundColor: Colors.white70,
            backgroundColor: Colors.orange,
            padding: EdgeInsets.all(15),
            gap: 8,
            onTabChange: (index) {
              setState(() {
                posicion = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.person,
                text: "Perfil",
                hoverColor: Colors.amber,
              ),
              GButton(
                  icon: Icons.fastfood,
                  text: "Carta",
                  hoverColor: Colors.amber),
              GButton(icon: Icons.map, text: "Mapa", hoverColor: Colors.amber),
              GButton(
                  icon: Icons.settings,
                  text: "Ajustes",
                  hoverColor: Colors.amber),
            ],
          )),
        )
      ],
    );
  }
}
