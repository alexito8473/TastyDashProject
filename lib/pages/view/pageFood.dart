import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/model/Food.dart';
import 'package:tfgsaladillo/model/Language.dart';
import 'package:tfgsaladillo/model/Coin.dart';

import '../../model/Person.dart';
import '../../model/Review.dart';
import '../widget/genericWidget.dart';
import '../widget/pageFoodWidget.dart';

class PageFood extends StatefulWidget {
  final Food comida;
  final Language idioma;
  final Coin monedaEnUso;
  final Person? person;
  final Function anadirQuitarProducto;

  const PageFood({
    super.key,
    required this.comida,
    required this.idioma,
    required this.monedaEnUso,
    required this.person,
    required this.anadirQuitarProducto,
  });

  @override
  State<StatefulWidget> createState() => _PageFood();
}

class _PageFood extends State<PageFood> {
  void addOrRemoveList(bool have, String product) async {
    DatabaseReference date = FirebaseDatabase.instance.ref();
    setState(() {
      if (have) {
        widget.person!.listaComida!.remove(product);
      } else {
        widget.person!.listaComida!.add(product);
      }
    });
    await date
        .child(
            "Person/${widget.person!.gmail.trim().split("@")[0].toLowerCase()}/listaComida")
        .set(widget.person!.listaComida!);
    widget.anadirQuitarProducto(widget.person!.listaComida);
  }

  void addReview() {
    setState(() {
      widget.comida.listReview.add(Review(
          autor: 'alejandro',
          publicacion: DateTime.now(),
          valoracion: 5,
          content:
              'Hola madre mia esto es algo madfnasdjfbasdjfasdklfbasjdbasdhmnbcuasdb fasdbfuasdfhasdbfjhsfhbashfbsjfajfbasfjhqwebfuisdbfasdbdfhsehfasdvcyhasbdjkfaseuifshfbvasdhvbasifbuyasefbasdfv'));
      widget.comida.valoracion += 5;
      widget.comida.numValoracion += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double resultValoracion =
        widget.comida.valoracion / widget.comida.numValoracion;
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
                      child: CachedNetworkImage(
                        imageUrl: widget.comida.foto,
                        height: size.height * 0.654,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ))),
            if (widget.person != null)
              Positioned(
                right: 0,
                child: SafeArea(
                    child: GestureDetector(
                  onTap: () {
                    addOrRemoveList(
                        widget.person!.listaComida!
                            .contains(widget.comida.nombre),
                        widget.comida.nombre);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: EdgeInsets.only(
                        right: size.height * 0.02, top: size.height * 0.02),
                    width: size.height * 0.07,
                    height: size.height * 0.07,
                    child: Icon(
                      color: Colors.orange,
                      widget.person!.listaComida!.contains(widget.comida.nombre)
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      size: size.height * 0.05,
                    ),
                  ),
                )),
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: size.width * 0.65,
                            margin: EdgeInsets.only(
                                bottom: size.height * 0.03,
                                left: size.width * 0.03,
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
                        if (widget.person != null)
                          Container(
                            margin: EdgeInsets.only(right: size.width * 0.05),
                            width: size.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 30,
                                ),
                                Text(
                                  "${resultValoracion.isNaN ? 0.0 : resultValoracion}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
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
                  GestureDetector(
                    onTap: () {
                      addReview();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.orange, Colors.orange.shade800])),
                      margin: EdgeInsets.only(
                          top: size.height * 0.02, bottom: size.height * 0.02),
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      child: const Text(
                        "Añadir Review",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ExpansionAlergenos(widget.comida, widget.idioma),
                  if (widget.comida.ingredientes.isNotEmpty)
                    ExpansionIngredientes(widget.comida, widget.idioma),
                  if (widget.person != null)
                    ExpansionReview(widget.comida, widget.idioma),
                ],
              )),
            ),
          ],
        ),
        floatingActionButton: const ButtonBack());
  }
}
