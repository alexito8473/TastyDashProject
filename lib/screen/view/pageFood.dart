import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/screen/view/viewReview.dart';

import '../../models/Person.dart';
import '../../services/RealTimeServices.dart';
import '../widget/genericWidget.dart';
import '../widget/pageFoodWidget.dart';

class PageFood extends StatefulWidget {
  final Food food;
  final Language language;
  final Coin coin;
  final Person? person;
  final Function function;

  const PageFood({
    super.key,
    required this.food,
    required this.language,
    required this.coin,
    required this.person,
    required this.function,
  });

  @override
  State<StatefulWidget> createState() => _PageFood();
}

class _PageFood extends State<PageFood> {
  void addOrRemoveList(bool have, String product) async {
    setState(() {
      if (have) {
        widget.person!.listFood!.remove(product);
      } else {
        widget.person!.listFood!.add(product);
      }
    });
    RealTimeService.updateListFoodUser(widget.person!);
    widget.function(widget.person!.listFood);
  }

  void activeFood() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double resultValoracion =
        widget.food.valoracion / widget.food.numValoracion;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                width: size.width,
                child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            stops: [0.4, 0.9],
                            colors: [Colors.transparent, Colors.black])
                        .createShader(bounds),
                    blendMode: BlendMode.darken,
                    child: Container(
                        width: size.width,
                        alignment: Alignment.topRight,
                        height: size.height * 0.34,
                        child: Hero(
                          tag: widget.food.foto,
                          child: CachedNetworkImage(
                            imageUrl: widget.food.foto,
                            height: size.height * 0.654,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )))),
            if (widget.person != null)
              Positioned(
                right: 0,
                child: SafeArea(
                    child: GestureDetector(
                  onTap: () {
                    addOrRemoveList(
                        widget.person!.listFood!.contains(widget.food.nombre),
                        widget.food.nombre);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: EdgeInsets.only(
                        right: size.height * 0.02, top: size.height * 0.02),
                    width: size.height * 0.07,
                    height: size.height * 0.07,
                    child: Icon(
                      color: Colors.orange,
                      widget.person!.listFood!.contains(widget.food.nombre)
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      size: size.height * 0.05,
                    ),
                  ),
                )),
              ),
            Container(
              width: size.width,
              height: size.height,
              margin: EdgeInsets.only(top: size.height * 0.3),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/fondoSuelo.webp"),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black26, BlendMode.darken))),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: size.width * 0.65,
                            margin: EdgeInsets.only(
                                bottom: size.height * 0.03,
                                left: size.width * 0.03,
                                top: size.height * 0.03),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              widget.food.nombre,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            )),
                        if (widget.person != null)
                          Container(
                            margin: EdgeInsets.only(right: size.width * 0.05),
                            width: size.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 30,
                                ),
                                Text(
                                  "${resultValoracion.isNaN ? 0.0 : resultValoracion}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(children: [
                    Expanded(
                        child: Center(
                      child: AutoSizeText(
                        "${widget.language.datosJson[widget.language.positionIdioma]["Precio"]}: ${(widget.food.precio * widget.coin.conversor).toStringAsFixed(2)} ${widget.coin.simbolo}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    )),
                    Expanded(
                        child: Center(
                      child: AutoSizeText(
                        maxLines: 1,
                        "${widget.food.tiempoMinuto} ${widget.language.datosJson[widget.language.positionIdioma]["Minuto"]}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                        textAlign: TextAlign.left,
                      ),
                    )),
                  ]),
                  ExpansionAllergen(widget.food, widget.language),
                  if (widget.food.ingredients.isNotEmpty)
                    ExpansionIngredients(widget.food, widget.language),
                ],
              )),
            ),
          ],
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: widget.person == null
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceBetween,
          children: [
            if (widget.person != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageReview(
                          person: widget.person!,
                          food: widget.food,
                          function: activeFood,
                        ),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.orange, Colors.orange.shade800])),
                  margin: EdgeInsets.only(
                      top: size.height * 0.02,
                      bottom: size.height * 0.02,
                      left: size.width * 0.05),
                  width: size.width * 0.4,
                  height: size.height * 0.06,
                  child: const Text(
                    "Ver reviews",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.05),
              child: const ButtonBack(),
            )
          ],
        ));
  }
}
