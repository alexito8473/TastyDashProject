import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';

import '../../models/Review.dart';

class AllergenRow extends StatelessWidget {
  final String type;
  final bool have;
  final Language language;
  final Size size;

  const AllergenRow(
      {super.key,
      required this.type,
      required this.have,
      required this.language,
      required this.size});

  String _contain() {
    return have
        ? language.dataJson[language.positionLanguage]["Contiene"]
        : language.dataJson[language.positionLanguage]["NoContiene"];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: size.width * 0.3,
              child: AutoSizeText(
                maxLines: 1,
                type,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.left,
              )),
          SizedBox(
            width: size.width * 0.3,
            child: AutoSizeText(
              maxLines: 1,
              _contain(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandAllergen extends StatelessWidget {
  final Food food;
  final Language language;
  final Size size;
  const ExpandAllergen(this.food, this.language, {super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      expansionAnimationStyle: AnimationStyle(curve: Curves.easeOut),
      title: Text(language.dataJson[language.positionLanguage]["Alergeno"],
          style: const TextStyle(color: Colors.white, fontSize: 25)),
      children: [
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Apio"],
          have: food.haveCelery,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Moluscos"],
          have: food.haveMollusks,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Crustaceos"],
          have: food.haveCrustaceans,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Mostaza"],
          have: food.haveMustard,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Huevo"],
          have: food.haveEgg,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Pescado"],
          have: food.haveFish,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Cacahuetes"],
          have: food.havePeanuts,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Gluten"],
          have: food.haveGluten,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.dataJson[language.positionLanguage]["Azufre"],
          have: food.haveSulfur,
          language: language,
          size: size,
        ),
      ],
    );
  }
}

class ExpandIngredients extends StatelessWidget {
  final Food food;
  final Language language;
  final Size size;
  const ExpandIngredients(this.food, this.language, {super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(language.dataJson[language.positionLanguage]["Ingredientes"],
          style: const TextStyle(color: Colors.white, fontSize: 25)),
      children: [
        SizedBox(
            width: size.width * 0.9,
            child: Text(
              food.ingredients
                  .map((e) => language.dataJson[language.positionLanguage][e])
                  .join(", "),
              style: const TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}
