import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/view/listFood.dart';
import 'package:tfgsaladillo/pages/view/pageFood.dart';

import '../../model/Person.dart';
import '../widget/letterWidget.dart';

class Carta extends StatefulWidget {
  final List<Comida> listaDeComida;
  final Idioma idioma;
  final Moneda monedaEnUso;
  final Person? person;

  const Carta(
      {super.key,
      required this.listaDeComida,
      required this.idioma,
      required this.monedaEnUso,
      required this.person});

  @override
  State<Carta> createState() => _Carta();
}

class _Carta extends State<Carta> {
  late String imagenActual;

  @override
  void initState() {
    imagenActual = widget.listaDeComida[0].foto;
    super.initState();
  }

  void NavegarLista(
      List<Comida> listaDeUnaComida, String imagenBanner, String nombreLista) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ListFood(
            listaComida: listaDeUnaComida,
            imagenBanner: imagenBanner,
            monedEnUso: widget.monedaEnUso,
            idioma: widget.idioma,
            nombreLista: nombreLista,
            person: widget.person,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Container(
            width: size.width,
            height: size.height,
            color: Colors.black,
            child: SingleChildScrollView(
                child: Column(children: [
              ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          stops: [
                            0.2,
                            0.6,
                            1
                          ],
                          colors: [
                            Colors.transparent,
                            Colors.black26,
                            Colors.black
                          ]).createShader(bounds),
                  blendMode: BlendMode.darken,
                  child: SizedBox(
                      width: size.width,
                      height: size.height * 0.5,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: imagenActual,
                            height: size.height * 0.6,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: size.height * 0.1),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    pageSnapping: true,
                                    enlargeFactor: 0.35,
                                    height: size.height * 0.35,
                                    initialPage: 0,
                                    disableCenter: false,
                                    viewportFraction: 0.65,
                                    enableInfiniteScroll: true,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 8),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.easeInCubic,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) =>
                                        setState(() {
                                          imagenActual =
                                              widget.listaDeComida[index].foto;
                                        }),
                                    scrollDirection: Axis.horizontal),
                                items: widget.listaDeComida.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return ComidaViewCarrusel(
                                        comida: i,
                                        monedaEnUso: widget.monedaEnUso,
                                        idioma: widget.idioma,
                                        person: widget.person,
                                        size: size,
                                      );
                                    },
                                  );
                                }).toList(),
                              )),
                        ],
                      ))),
              Container(
                  width: size.width,
                  height: size.height * 0.43,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: const AssetImage(
                              "assets/images/bannerFiltros.webp"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7),
                              BlendMode.darken))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BotonNavegacion(
                              function: () => {
                                NavegarLista(
                                    widget.listaDeComida
                                        .where((element) => element.isBurguer)
                                        .toList(),
                                    "assets/images/hamburguesasBanner.webp",
                                    widget.idioma.datosJson[widget
                                        .idioma.positionIdioma]["HoverHambur"])
                              },
                              idioma: widget.idioma,
                              svgpPath: 'assets/Icons/Burguer.svg',
                              color: Colors.orange.shade300,
                              tipoComida: 'HoverHambur',
                              size: size,
                            ),
                            BotonNavegacion(
                              function: () => {
                                NavegarLista(
                                    widget.listaDeComida
                                        .where((element) => element.isEnsalada)
                                        .toList(),
                                    "assets/images/ensaladaBanner.webp",
                                    widget.idioma.datosJson[widget
                                        .idioma.positionIdioma]["HoverEnsa"])
                              },
                              idioma: widget.idioma,
                              svgpPath: 'assets/Icons/Salad.svg',
                              color: Colors.green.shade300,
                              tipoComida: 'HoverEnsa',
                              size: size,
                            ),
                            BotonNavegacion(
                              function: () => {
                                NavegarLista(
                                    widget.listaDeComida
                                        .where((element) => element.isPescado)
                                        .toList(),
                                    "assets/images/bannerPescado.webp",
                                    widget.idioma.datosJson[widget
                                        .idioma.positionIdioma]["HoverPesca"])
                              },
                              idioma: widget.idioma,
                              svgpPath: 'assets/Icons/Fish.svg',
                              color: Colors.blue.shade300,
                              tipoComida: 'HoverPesca',
                              size: size,
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BotonNavegacion(
                                function: () => {
                                  NavegarLista(
                                      widget.listaDeComida
                                          .where((element) => element.isCarne)
                                          .toList(),
                                      "assets/images/bannerCarne.webp",
                                      widget.idioma.datosJson[widget
                                          .idioma.positionIdioma]["HoverCarne"])
                                },
                                idioma: widget.idioma,
                                svgpPath: 'assets/Icons/Meat.svg',
                                color: Colors.lime.shade300,
                                tipoComida: 'HoverCarne',
                                size: size,
                              ),
                              BotonNavegacion(
                                function: () => {
                                  NavegarLista(
                                      widget.listaDeComida
                                          .where((element) => element.isBebida)
                                          .toList(),
                                      "assets/images/bannerBebida.webp",
                                      widget.idioma.datosJson[widget.idioma
                                          .positionIdioma]["HoverBebida"])
                                },
                                idioma: widget.idioma,
                                svgpPath: 'assets/Icons/Drink.svg',
                                color: Colors.red,
                                tipoComida: 'HoverBebida',
                                size: size,
                              ),
                              BotonNavegacion(
                                function: () => {
                                  NavegarLista(
                                      widget.listaDeComida
                                          .where((element) => element.isPostre)
                                          .toList(),
                                      "assets/images/bannerPostre.webp",
                                      widget.idioma.datosJson[widget
                                          .idioma.positionIdioma]["Postre"])
                                },
                                idioma: widget.idioma,
                                svgpPath: 'assets/Icons/Postre.svg',
                                color: Colors.yellow.shade300,
                                tipoComida: 'Postre',
                                size: size,
                              )
                            ])
                      ]))
            ]))));
  }
}

class ComidaViewCarrusel extends StatelessWidget {
  final Comida comida;
  final Moneda monedaEnUso;
  final Idioma idioma;
  final Person? person;
  final Size size;

  const ComidaViewCarrusel(
      {super.key,
      required this.comida,
      required this.monedaEnUso,
      required this.idioma,
      required this.person,
      required this.size});

  void vacio(List list) {}

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
                      comida: comida,
                      idioma: idioma,
                      monedaEnUso: monedaEnUso,
                      person: person,
                      anadirQuitarProducto: vacio,
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
                ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // Ajusta el radio de los bordes
                    child: CachedNetworkImage(
                      imageUrl: comida.foto,
                      height: size.height * 0.16,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
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
