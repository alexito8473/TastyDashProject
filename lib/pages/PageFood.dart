import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';

class PaginaComida extends StatefulWidget {
  final Comida comida;
  final Idioma idioma;
  final Moneda monedaEnUso;
  const PaginaComida(
      {super.key,
      required this.comida,
      required this.idioma,
      required this.monedaEnUso});
  @override
  State<StatefulWidget> createState() => _PaginaComida();
}

class _PaginaComida extends State<PaginaComida> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                width: size.width,
                child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            stops: [0.4, 0.9],
                            colors: [Colors.transparent, Colors.black])
                        .createShader(bounds),
                    blendMode: BlendMode.darken,
                    child: Container(
                        width: size.width,
                        alignment: Alignment.topRight,
                        height: size.height * 0.34,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage(widget.comida.foto),
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                isAntiAlias: true))))),
            Container(
              width: size.width,
              height: size.height,
              margin: EdgeInsets.only(top: size.height * 0.3),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/fondoSuelo.webp"),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black26, BlendMode.darken))),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: size.width * 0.7,
                            margin: EdgeInsets.only(
                                bottom: size.height * 0.03,
                                left: size.width * 0.01,
                                top: size.height * 0.03),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              widget.comida.nombre,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            )),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                right: size.height * 0.01),
                            width: size.height * 0.07,
                            height: size.height * 0.07,
                            child: Icon(
                              color: Colors.orange,
                              Icons.star_border_outlined,
                              size: size.height * 0.07,
                            ),
                            //Icons.star_border_outlined,
                            // Icons.star,
                          ),
                        )
                      ],
                    ),
                  ),

                  Row(children: [
                    Expanded(
                        child: Center(
                      child: AutoSizeText(
                        "${widget.idioma.datosJson[widget.idioma.positionIdioma]["Precio"]}: ${(widget.comida.precio * widget.monedaEnUso.conversor).toStringAsFixed(2)} ${widget.monedaEnUso.simbolo}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    )),
                    Expanded(
                        child: Center(
                      child: AutoSizeText(
                        maxLines: 1,
                        "${widget.comida.tiempoMinuto} ${widget.idioma.datosJson[widget.idioma.positionIdioma]["Minuto"]}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                        textAlign: TextAlign.left,
                      ),
                    )),
                  ]),
                  ExpansionAlergenos(widget.comida, widget.idioma),
                  if (widget.comida.ingredientes.isNotEmpty)
                    ExpansionIngredientes(widget.comida, widget.idioma),
                ],
              )),
            ),
          ],
        ),
        floatingActionButton: BotonVolver());
  }
}

class ExpansionIngredientes extends StatelessWidget {
  final Comida comida;
  final Idioma idioma;
  const ExpansionIngredientes(this.comida, this.idioma, {super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(idioma.datosJson[idioma.positionIdioma]["Ingredientes"],
          style: const TextStyle(color: Colors.white, fontSize: 25)),
      children: [
        Container(
            width: size.width * 0.9,
            child: Text(
              comida.ingredientes
                  .map((e) => idioma.datosJson[idioma.positionIdioma][e])
                  .join(", "),
              style: const TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}

class ExpansionAlergenos extends StatelessWidget {
  final Comida comida;
  final Idioma idioma;
  const ExpansionAlergenos(this.comida, this.idioma, {super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      expansionAnimationStyle: AnimationStyle(curve: Curves.easeOut),
      title: Text(idioma.datosJson[idioma.positionIdioma]["Alergeno"],
          style: const TextStyle(color: Colors.white, fontSize: 25)),
      children: [
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Apio"],
            comida.haveApio, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Moluscos"],
            comida.haveMoluscos, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Crustaceos"],
            comida.haveCrustaceos, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Mostaza"],
            comida.haveMostaza, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Huevo"],
            comida.haveHuevo, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Pescado"],
            comida.havePescado, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Cacahuetes"],
            comida.haveCacahuetes, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Gluten"],
            comida.haveGluten, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Azufre"],
            comida.haveAzufre, idioma, size),
      ],
    );
  }
}

String contiene(bool isContiene, Idioma idioma) {
  return isContiene
      ? idioma.datosJson[idioma.positionIdioma]["Contiene"]
      : idioma.datosJson[idioma.positionIdioma]["NoContiene"];
}

Widget FilaAlergeno(String tipo, bool tiene, Idioma idioma, Size size) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: size.width * 0.3,
            child: AutoSizeText(
              maxLines: 1,
              tipo,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.left,
            )),
        SizedBox(
          width: size.width * 0.3,
          child: AutoSizeText(
            maxLines: 1,
            contiene(tiene, idioma),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ),
  );
}
