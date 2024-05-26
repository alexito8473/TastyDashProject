import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/screen/view/pageFood.dart';

import '../../models/Person.dart';

class BannerFood extends StatelessWidget {
  final Food comida;
  final Coin monedaEnUso;
  final Language idioma;
  final Person? person;
  final Function anadirQuitarProducto;

  const BannerFood(
      {super.key,
      required this.comida,
      required this.monedaEnUso,
      required this.idioma,
      required this.person,
      required this.anadirQuitarProducto});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          barrierColor: Colors.black54,
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
                opacity: animation,
                child: PageFood(
                  food: comida,
                  language: idioma,
                  coin: monedaEnUso,
                  person: person,
                  function: anadirQuitarProducto,
                ));
          },
        ));
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaginaComida(comida: comida),));
      },
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          width: double.infinity,
          height: size.height * 0.15,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(
                      25.0), // Ajusta el radio de los bordes
                  child: CachedNetworkImage(
                    imageUrl: comida.foto,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    color: Colors.black54,
                    colorBlendMode: BlendMode.darken,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    maxLines: 1,
                    comida.nombre,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: AutoSizeText(
                          "${idioma.datosJson[idioma.positionIdioma]["Precio"]}: ${(comida.precio * monedaEnUso.conversor).toStringAsFixed(2)} ${monedaEnUso.simbolo}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                      )),
                      Expanded(
                          child: Center(
                        child: AutoSizeText(
                          maxLines: 1,
                          "${comida.tiempoMinuto} ${idioma.datosJson[idioma.positionIdioma]["Minuto"]}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                        ),
                      )),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
