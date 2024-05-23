import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Food.dart';
import 'package:tfgsaladillo/model/Language.dart';
import 'package:intl/intl.dart';
import '../../model/Review.dart';

String contiene(bool isContiene, Language idioma) {
  return isContiene
      ? idioma.datosJson[idioma.positionIdioma]["Contiene"]
      : idioma.datosJson[idioma.positionIdioma]["NoContiene"];
}

Widget FilaAlergeno(String tipo, bool tiene, Language idioma, Size size) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: size.width * 0.3,
            child: AutoSizeText(
              maxLines: 1,
              tipo,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.left,
            )),
        SizedBox(
          width: size.width * 0.3,
          child: AutoSizeText(
            maxLines: 1,
            contiene(tiene, idioma),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ),
  );
}

class ExpansionAlergenos extends StatelessWidget {
  final Food comida;
  final Language idioma;

  const ExpansionAlergenos(this.comida, this.idioma, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      expansionAnimationStyle: AnimationStyle(curve: Curves.easeOut),
      title: Text(idioma.datosJson[idioma.positionIdioma]["Alergeno"],
          style: const TextStyle(color: Colors.white, fontSize: 25)),
      children: [
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Apio"],
            comida.haveApio, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Moluscos"],
            comida.haveMoluscos, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Crustaceos"],
            comida.haveCrustaceos, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Mostaza"],
            comida.haveMostaza, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Huevo"],
            comida.haveHuevo, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Pescado"],
            comida.havePescado, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Cacahuetes"],
            comida.haveCacahuetes, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Gluten"],
            comida.haveGluten, idioma, size),
        FilaAlergeno(idioma.datosJson[idioma.positionIdioma]["Azufre"],
            comida.haveAzufre, idioma, size),
      ],
    );
  }
}

class ExpansionIngredientes extends StatelessWidget {
  final Food comida;
  final Language idioma;
  const ExpansionIngredientes(this.comida, this.idioma, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: Colors.orange,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(idioma.datosJson[idioma.positionIdioma]["Ingredientes"],
          style: const TextStyle(color: Colors.white, fontSize: 25)),
      children: [
        SizedBox(
            width: size.width * 0.9,
            child: Text(
              comida.ingredientes
                  .map((e) => idioma.datosJson[idioma.positionIdioma][e])
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
              builder: (context) =>  AlertDialog(
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
                            ))
                  ,
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
                          Text("Tiene una valoración de : ${review.valoracion}/5.0.",style: const TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                          Text(review.content,style: const TextStyle(fontSize: 20))
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
