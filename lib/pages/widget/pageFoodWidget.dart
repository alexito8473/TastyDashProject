import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';

String contiene(bool isContiene, Idioma idioma) {
  return isContiene
      ? idioma.datosJson[idioma.positionIdioma]["Contiene"]
      : idioma.datosJson[idioma.positionIdioma]["NoContiene"];
}

Widget FilaAlergeno(String tipo, bool tiene, Idioma idioma, Size size) {
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
  final Comida comida;
  final Idioma idioma;

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
  final Comida comida;
  final Idioma idioma;

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
