import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/Food.dart';
import '../../models/Language.dart';
import '../../models/Coin.dart';
import '../../models/Person.dart';
import '../view/pageFood.dart';

class ShowList extends StatefulWidget {
  final Size size;
  final List<Food> listaComida;
  final Coin monedaEnUso;
  final Language idioma;
  final Person person;
  final Function anadirQuitarProducto;

  const ShowList(
      {super.key,
      required this.size,
      required this.listaComida,
      required this.monedaEnUso,
      required this.idioma,
      required this.person,
      required this.anadirQuitarProducto});

  @override
  State<StatefulWidget> createState() => _ShowList();
}

class _ShowList extends State<ShowList> {
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
  final Food comida;
  final Coin monedaEnUso;
  final Language idioma;
  final Person person;
  final List<Food> listComida;
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
                  food: widget.comida,
                  language: widget.idioma,
                  coin: widget.monedaEnUso,
                  person: widget.person,
                  function: widget.anadirQuitarProducto,
                ));
          },
        ));
        setState(() {});
      },
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          height: size.height * 0.15,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(
                      25.0), // Ajusta el radio de los bordes
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    color: Colors.black54,
                    colorBlendMode: BlendMode.darken,
                    imageUrl: widget.comida.foto,
                  )),
              Center(
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
                  RatingBar(
                    initialRating: widget.comida.valoracion,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemSize: size.width * 0.07,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(Icons.star, color: Colors.orange),
                      empty: const Icon(Icons.star, color: Colors.grey),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  AutoSizeText(
                    maxLines: 1,
                    "${widget.comida.tiempoMinuto} ${widget.idioma.datosJson[widget.idioma.positionIdioma]["Minuto"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
