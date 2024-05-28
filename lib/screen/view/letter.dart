import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/screen/view/listFood.dart';
import 'package:tfgsaladillo/screen/view/pageFood.dart';

import '../../models/Person.dart';
import '../widget/letterWidget.dart';

class Letter extends StatefulWidget {
  final List<Food> listFood;
  final Language language;
  final Coin coin;
  final Person? person;

  const Letter(
      {super.key,
      required this.listFood,
      required this.language,
      required this.coin,
      required this.person});

  @override
  State<Letter> createState() => _Carta();
}

class _Carta extends State<Letter> {
  late String currentImage;

  @override
  void initState() {
    currentImage = widget.listFood[0].pathImage;
    super.initState();
  }

  void navigationList(
      List<Food> listOneFood, String imageBanner, String nameList) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ListFood(
            listFood: listOneFood,
            imageBanner: imageBanner,
            coin: widget.coin,
            language: widget.language,
            nameList: nameList,
            person: widget.person,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                            imageUrl: currentImage,
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
                                          currentImage =
                                              widget.listFood[index].pathImage;
                                        }),
                                    scrollDirection: Axis.horizontal),
                                items: widget.listFood.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return ComidaViewCarrusel(
                                        comida: i,
                                        monedaEnUso: widget.coin,
                                        idioma: widget.language,
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
                                navigationList(
                                    widget.listFood
                                        .where((element) => element.isBurguer)
                                        .toList(),
                                    "assets/images/hamburguesasBanner.webp",
                                    widget.language.dataJson[widget.language
                                        .positionLanguage]["HoverHambur"])
                              },
                              idioma: widget.language,
                              svgpPath: 'assets/Icons/Burguer.svg',
                              color: Colors.orange.shade300,
                              tipoComida: 'HoverHambur',
                              size: size,
                            ),
                            BotonNavegacion(
                              function: () => {
                                navigationList(
                                    widget.listFood
                                        .where((element) => element.isSalad)
                                        .toList(),
                                    "assets/images/ensaladaBanner.webp",
                                    widget.language.dataJson[widget
                                        .language.positionLanguage]["HoverEnsa"])
                              },
                              idioma: widget.language,
                              svgpPath: 'assets/Icons/Salad.svg',
                              color: Colors.green.shade300,
                              tipoComida: 'HoverEnsa',
                              size: size,
                            ),
                            BotonNavegacion(
                              function: () => {
                                navigationList(
                                    widget.listFood
                                        .where((element) => element.isFish)
                                        .toList(),
                                    "assets/images/bannerPescado.webp",
                                    widget.language.dataJson[widget
                                        .language.positionLanguage]["HoverPesca"])
                              },
                              idioma: widget.language,
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
                                  navigationList(
                                      widget.listFood
                                          .where((element) => element.isMeat)
                                          .toList(),
                                      "assets/images/bannerCarne.webp",
                                      widget.language.dataJson[widget.language
                                          .positionLanguage]["HoverCarne"])
                                },
                                idioma: widget.language,
                                svgpPath: 'assets/Icons/Meat.svg',
                                color: Colors.lime.shade300,
                                tipoComida: 'HoverCarne',
                                size: size,
                              ),
                              BotonNavegacion(
                                function: () => {
                                  navigationList(
                                      widget.listFood
                                          .where((element) => element.isDrink)
                                          .toList(),
                                      "assets/images/bannerBebida.webp",
                                      widget.language.dataJson[widget.language
                                          .positionLanguage]["HoverBebida"])
                                },
                                idioma: widget.language,
                                svgpPath: 'assets/Icons/Drink.svg',
                                color: Colors.red,
                                tipoComida: 'HoverBebida',
                                size: size,
                              ),
                              BotonNavegacion(
                                function: () => {
                                  navigationList(
                                      widget.listFood
                                          .where((element) => element.isDessert)
                                          .toList(),
                                      "assets/images/bannerPostre.webp",
                                      widget.language.dataJson[widget
                                          .language.positionLanguage]["Postre"])
                                },
                                idioma: widget.language,
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
                      food: comida,
                      language: idioma,
                      coin: monedaEnUso,
                      person: person,
                      function: vacio,
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
                      imageUrl: comida.pathImage,
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
                            comida.name,
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
                            "${idioma.dataJson[idioma.positionLanguage]["Precio"]}: ${(comida.price * monedaEnUso.converter).toStringAsFixed(2)} ${monedaEnUso.symbol}",
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
