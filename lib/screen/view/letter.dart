import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/widget/letterWidget.dart';
import 'listFood.dart';

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
  State<Letter> createState() => _LetterState();
}

class _LetterState extends State<Letter> {
  late String _currentImage;

  @override
  void initState() {
    _currentImage = widget.listFood[0].pathImage;
    super.initState();
  }

  void _navigationList(
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
                            imageUrl: _currentImage,
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
                                          _currentImage =
                                              widget.listFood[index].pathImage;
                                        }),
                                    scrollDirection: Axis.horizontal),
                                items: widget.listFood.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return FoodViewCarousel(
                                        food: i,
                                        coin: widget.coin,
                                        language: widget.language,
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
                            ButtonNavigation(
                              function: () => {
                                _navigationList(
                                    widget.listFood
                                        .where((element) => element.isBurguer)
                                        .toList(),
                                    "assets/images/hamburguesasBanner.webp",
                                    widget.language.dataJson[widget.language
                                        .positionLanguage]["HoverHambur"])
                              },
                              language: widget.language,
                              pathSvg: 'assets/Icons/Burguer.svg',
                              color: Colors.orange.shade300,
                              size: size,
                            ),
                            ButtonNavigation(
                              function: () => {
                                _navigationList(
                                    widget.listFood
                                        .where((element) => element.isSalad)
                                        .toList(),
                                    "assets/images/ensaladaBanner.webp",
                                    widget.language.dataJson[widget.language
                                        .positionLanguage]["HoverEnsa"])
                              },
                              language: widget.language,
                              pathSvg: 'assets/Icons/Salad.svg',
                              color: Colors.green.shade300,
                              size: size,
                            ),
                            ButtonNavigation(
                              function: () => {
                                _navigationList(
                                    widget.listFood
                                        .where((element) => element.isFish)
                                        .toList(),
                                    "assets/images/bannerPescado.webp",
                                    widget.language.dataJson[widget.language
                                        .positionLanguage]["HoverPesca"])
                              },
                              language: widget.language,
                              pathSvg: 'assets/Icons/Fish.svg',
                              color: Colors.blue.shade300,
                              size: size,
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonNavigation(
                                function: () => {
                                  _navigationList(
                                      widget.listFood
                                          .where((element) => element.isMeat)
                                          .toList(),
                                      "assets/images/bannerCarne.webp",
                                      widget.language.dataJson[widget.language
                                          .positionLanguage]["HoverCarne"])
                                },
                                language: widget.language,
                                pathSvg: 'assets/Icons/Meat.svg',
                                color: Colors.lime.shade300,
                                size: size,
                              ),
                              ButtonNavigation(
                                function: () => {
                                  _navigationList(
                                      widget.listFood
                                          .where((element) => element.isDrink)
                                          .toList(),
                                      "assets/images/bannerBebida.webp",
                                      widget.language.dataJson[widget.language
                                          .positionLanguage]["HoverBebida"])
                                },
                                language: widget.language,
                                pathSvg: 'assets/Icons/Drink.svg',
                                color: Colors.red,
                                size: size,
                              ),
                              ButtonNavigation(
                                function: () => {
                                  _navigationList(
                                      widget.listFood
                                          .where((element) => element.isDessert)
                                          .toList(),
                                      "assets/images/bannerPostre.webp",
                                      widget.language.dataJson[widget
                                          .language.positionLanguage]["Postre"])
                                },
                                language: widget.language,
                                pathSvg: 'assets/Icons/Postre.svg',
                                color: Colors.yellow.shade300,
                                size: size,
                              )
                            ])
                      ]))
            ]))));
  }
}
