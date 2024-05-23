import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:intl/intl.dart';
import '../../models/Review.dart';

String contiene(bool isContiene, Language idioma) {
  return isContiene
      ? idioma.datosJson[idioma.positionIdioma]["Contiene"]
      : idioma.datosJson[idioma.positionIdioma]["NoContiene"];
}

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
              contiene(have, language),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpansionAllergen extends StatelessWidget {
  final Food food;
  final Language language;

  const ExpansionAllergen(this.food, this.language, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      expansionAnimationStyle: AnimationStyle(curve: Curves.easeOut),
      title: Text(language.datosJson[language.positionIdioma]["Alergeno"],
          style: const TextStyle(color: Colors.white, fontSize: 25)),
      children: [
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Apio"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Moluscos"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Crustaceos"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Mostaza"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Huevo"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Pescado"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Cacahuetes"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Gluten"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
        AllergenRow(
          type: language.datosJson[language.positionIdioma]["Azufre"],
          have: food.haveApio,
          language: language,
          size: size,
        ),
      ],
    );
  }
}

class ExpansionIngredients extends StatelessWidget {
  final Food food;
  final Language language;
  const ExpansionIngredients(this.food, this.language, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(language.datosJson[language.positionIdioma]["Ingredientes"],
          style: const TextStyle(color: Colors.white, fontSize: 25)),
      children: [
        SizedBox(
            width: size.width * 0.9,
            child: Text(
              food.ingredients
                  .map((e) => language.datosJson[language.positionIdioma][e])
                  .join(", "),
              style: const TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}

class ExpansionReview extends StatelessWidget {
  final Food comida;
  final Language idioma;
  const ExpansionReview(this.comida, this.idioma, {super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: const Text("Review",
          style: TextStyle(color: Colors.white, fontSize: 25)),
      expandedAlignment: Alignment.centerLeft,
      children: [
        ...List.generate(comida.listReview.length,
            (index) => ShowReview(review: comida.listReview[index]))
      ],
    );
  }
}

class ShowReview extends StatelessWidget {
  final Review review;
  const ShowReview({super.key, required this.review});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
        onTap: () {
          showDialog(
              barrierColor: Colors.black.withOpacity(0.7),
              useSafeArea: true,
              context: context,
              builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        "Realizado por " + review.autor,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )),
                      Text(
                        "Realizada a las " +
                            DateFormat("HH:mm yyyy/MM/dd")
                                .format(review.publicacion)
                                .toString(),
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  content: SizedBox(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tiene una valoración de : ${review.valoracion}/5.0.",
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          Text(review.content,
                              style: const TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                  )));
        },
        child: Container(
            margin: EdgeInsets.only(
                bottom: size.height * 0.01, left: size.width * 0.1),
            width: size.width * 0.65,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Colors.orange.shade800, Colors.red.shade500]),
                borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        review.autor,
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 30,
                          ),
                          Text(
                            "${review.valoracion}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        ],
                      )
                    ]),
                Text(
                  DateFormat("HH:mm yyyy/MM/dd")
                      .format(review.publicacion)
                      .toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            )));
  }
}
