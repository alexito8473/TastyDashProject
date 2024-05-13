// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/ListComida.dart';

class Carta extends StatefulWidget {
  final List<Comida> listaDeComida;
  final Idioma idioma;
  Moneda monedaEnUso;
  Carta(
      {super.key,
      required this.listaDeComida,
      required this.idioma,
      required this.monedaEnUso});
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
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ListaComida(
            listaComida: listaDeUnaComida,
            imagenBanner: imagenBanner,
            monedEnUso: widget.monedaEnUso,
            idioma: widget.idioma,
            nombreLista: nombreLista,
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
                  child: Container(
                      width: size.width,
                      height: size.height * 0.55,
                      padding: EdgeInsets.only(
                          top: size.height * 0.15, bottom: size.height * 0.05),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage(imagenActual),
                            fit: BoxFit.cover,
                          )),
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
                            autoPlayInterval: const Duration(seconds: 8),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.easeInCubic,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) => setState(() {
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
                              );
                            },
                          );
                        }).toList(),
                      ))),
              Container(
                  width: size.width,
                  height: size.height * 0.374,
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
                              ),
                              BotonNavegacion(
                                function: () => {
                                  NavegarLista(
                                      widget.listaDeComida,
                                      "assets/images/bannerBebida.webp",
                                      "Prueba")
                                },
                                idioma: widget.idioma,
                                svgpPath: 'assets/Icons/Menu.svg',
                                color: Colors.yellow.shade300,
                                tipoComida: 'HoverBebida',
                              ),
                            ])
                      ]))
            ]))));
  }
}

class BotonNavegacion extends StatelessWidget {
  final Function function;
  final Idioma idioma;
  final String svgpPath;
  final Color color;
  final String tipoComida;
  const BotonNavegacion(
      {super.key,
      required this.function,
      required this.idioma,
      required this.svgpPath,
      required this.color,
      required this.tipoComida});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
        heroTag: null,
        onPressed: () => function(),
        backgroundColor: color,
        tooltip: idioma.datosJson[idioma.positionIdioma][tipoComida],
        child: SvgPicture.asset(
          svgpPath,
          width: 60,
        ));
  }
}
