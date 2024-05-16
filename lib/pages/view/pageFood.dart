import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';

import '../../model/Person.dart';
import '../widget/genericWidget.dart';
import '../widget/pageFoodWidget.dart';

class PageFood extends StatefulWidget {
  final Comida comida;
  final Idioma idioma;
  final Moneda monedaEnUso;
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
  void addOrRemoveList(bool have, String product) {
    setState(() {
      if (have) {
        widget.person!.listaComida!.remove(product);
      } else {
        widget.person!.listaComida!.add(product);
      }
    });
    widget.anadirQuitarProducto(widget.person!.listaComida);
  }

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
                      child: CachedNetworkImage(
                        imageUrl: widget.comida.foto,
                        height: size.height * 0.654,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ))),
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
                        if (widget.person != null)
                          GestureDetector(
                            onTap: () {
                              addOrRemoveList(
                                  widget.person!.listaComida!
                                      .contains(widget.comida.nombre),
                                  widget.comida.nombre);
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: size.height * 0.01),
                              width: size.height * 0.07,
                              height: size.height * 0.07,
                              child: Icon(
                                color: Colors.orange,
                                widget.person!.listaComida!
                                        .contains(widget.comida.nombre)
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                size: size.height * 0.06,
                              ),
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
        floatingActionButton: const ButtonBack());
  }
}
