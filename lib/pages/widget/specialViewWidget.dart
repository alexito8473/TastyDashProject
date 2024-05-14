import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../model/Comida.dart';
import '../../model/Idioma.dart';
import '../../model/Moneda.dart';
import '../../model/Person.dart';
import '../view/pageFood.dart';

class MostrarLista extends StatefulWidget {
  final Size size;
  final List<Comida> listaComida;
  final Moneda monedaEnUso;
  final Idioma idioma;
  final Person person;
  final Function anadirQuitarProducto;

  const MostrarLista(
      {super.key,
      required this.size,
      required this.listaComida,
      required this.monedaEnUso,
      required this.idioma,
      required this.person,
      required this.anadirQuitarProducto});

  @override
  State<StatefulWidget> createState() => _MostrarLista();
}

class _MostrarLista extends State<MostrarLista> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      margin: EdgeInsets.only(
          top: widget.size.height * 0.01, bottom: widget.size.height * 0.01),
      child: GridView.builder(
        itemCount: widget.listaComida.length,
        itemBuilder: (context, index) {
          return BannerComidaGrid(
            comida: widget.listaComida[index],
            monedaEnUso: widget.monedaEnUso,
            idioma: widget.idioma,
            person: widget.person,
            anadirQuitarProducto: widget.anadirQuitarProducto,
            listComida: widget.listaComida,
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
    );
  }
}

class BannerComidaGrid extends StatefulWidget {
  final Comida comida;
  final Moneda monedaEnUso;
  final Idioma idioma;
  final Person person;
  final List<Comida> listComida;
  final Function anadirQuitarProducto;

  const BannerComidaGrid(
      {super.key,
      required this.comida,
      required this.monedaEnUso,
      required this.idioma,
      required this.person,
      required this.anadirQuitarProducto,
      required this.listComida});

  @override
  State<StatefulWidget> createState() => _BannerComidaGrid();
}

class _BannerComidaGrid extends State<BannerComidaGrid> {
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
                  comida: widget.comida,
                  idioma: widget.idioma,
                  monedaEnUso: widget.monedaEnUso,
                  person: widget.person,
                  anadirQuitarProducto: widget.anadirQuitarProducto,
                ));
          },
        ));
        setState(() {});
      },
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          height: size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(widget.comida.foto),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55), BlendMode.srcATop)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                maxLines: 1,
                widget.comida.nombre,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              AutoSizeText(
                "${widget.idioma.datosJson[widget.idioma.positionIdioma]["Precio"]}: ${(widget.comida.precio * widget.monedaEnUso.conversor).toStringAsFixed(2)} ${widget.monedaEnUso.simbolo}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.left,
                maxLines: 1,
              ),
              AutoSizeText(
                maxLines: 1,
                "${widget.comida.tiempoMinuto} ${widget.idioma.datosJson[widget.idioma.positionIdioma]["Minuto"]}",
                style: const TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.left,
              ),
            ],
          )),
    );
  }
}
