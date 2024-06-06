import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';
import '../view/pageFood.dart';

class ButtonNavigation extends StatelessWidget {
  final Function function;
  final Language language;
  final String pathSvg;
  final Color color;
  final Size size;

  const ButtonNavigation(
      {super.key,
      required this.function,
      required this.language,
      required this.pathSvg,
      required this.color,
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
              pathSvg,
            )));
  }
}

class FoodViewCarousel extends StatelessWidget {
  final Food food;
  final Coin coin;
  final Language language;
  final Person? person;
  final Size size;

  const FoodViewCarousel(
      {super.key,
      required this.food,
      required this.coin,
      required this.language,
      required this.person,
      required this.size});

  void miVoid(List list) {}
  void navigationToPageFood(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: PageFood(
            food: food,
            language: language,
            coin: coin,
            person: person,
            function: miVoid,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => navigationToPageFood(context),
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
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: food.pathImage,
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
                            food.name,
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
                            "${language.dataJson[language.positionLanguage]["Precio"]}: ${(food.price * coin.converter).toStringAsFixed(2)} ${coin.symbol}",
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
