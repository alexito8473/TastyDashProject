import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Person.dart';

import '../view/pageFood.dart';

class BotonNavegacion extends StatelessWidget {
  final Function function;
  final Language idioma;
  final String svgpPath;
  final Color color;
  final String tipoComida;
  final Size size;

  const BotonNavegacion(
      {super.key,
      required this.function,
      required this.idioma,
      required this.svgpPath,
      required this.color,
      required this.tipoComida,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => function(),
        child: Container(
            padding: EdgeInsets.all(size.width * 0.04),
            width: size.width * 0.23,
            height: size.width * 0.23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: color,
            ),
            child: SvgPicture.asset(
              svgpPath,
            )));
  }
}

class ComidaViewCarrusel extends StatelessWidget {
  final Food comida;
  final Coin monedaEnUso;
  final Language idioma;
  final Person? person;
  final Size size;

  const ComidaViewCarrusel(
      {super.key,
      required this.comida,
      required this.monedaEnUso,
      required this.idioma,
      required this.person,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
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
                      function: (List list) {},
                    ),
                  );
                },
              ))
            },
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage(comida.foto),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          isAntiAlias: true)),
                ),
                SizedBox(
                    width: double.infinity,
                    height: size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: AutoSizeText(
                            comida.nombre,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 30),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: AutoSizeText(
                            "${idioma.datosJson[idioma.positionIdioma]["Precio"]}: ${(comida.precio * monedaEnUso.conversor).toStringAsFixed(2)} ${monedaEnUso.simbolo}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ))
              ],
            ))));
  }
}
