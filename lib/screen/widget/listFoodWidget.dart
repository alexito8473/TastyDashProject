import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/view/pageFood.dart';


class BannerFood extends StatelessWidget {
  final Food food;
  final Coin coin;
  final Language language;
  final Person? person;
  final Function addOrRemoveProduct;

  const BannerFood(
      {super.key,
        required this.food,
        required this.coin,
        required this.language,
        required this.person,
        required this.addOrRemoveProduct});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                  food: food,
                  language: language,
                  coin: coin,
                  person: person,
                  function: addOrRemoveProduct,
                ));
          },
        ));
        },
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          width: double.infinity,
          height: size.height * 0.15,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(
                      25.0),
                  child: CachedNetworkImage(
                    imageUrl: food.pathImage,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    color: Colors.black54,
                    colorBlendMode: BlendMode.darken,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    maxLines: 1,
                    food.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Center(
                            child: AutoSizeText(
                              "${language.dataJson[language.positionLanguage]["Precio"]}: ${(food.price * coin.converter).toStringAsFixed(2)} ${coin.symbol}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                          )),
                      if(food.timeMinute>0)
                        Expanded(
                            child: Center(
                              child: AutoSizeText(
                                maxLines: 1,
                                "${food.timeMinute} ${language.dataJson[language.positionLanguage]["Minuto"]}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                                textAlign: TextAlign.left,
                              ),
                            )),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
