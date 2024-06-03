import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tfgsaladillo/models/Language.dart';

import '../../models/Coin.dart';
import '../../models/Food.dart';
import '../../models/Person.dart';
import '../widget/specialViewWidget.dart';

class SpecialView extends StatefulWidget {
  final Language language;
  final Size size;
  final List<Food> listFood;
  final Coin coin;
  final Function function;
  bool changeIconPrice;
  Person person;

  SpecialView(
      {super.key,
      required this.size,
      required this.language,
      required this.listFood,
      required this.coin,
      required this.changeIconPrice,
      required this.function,
      required this.person});

  @override
  State<SpecialView> createState() => _EspecialView();
}

class _EspecialView extends State<SpecialView> {
  late int cant = 0;
  late List<Food> listBurguer = [];
  late List<Food> listSalad = [];
  late List<Food> listFish = [];
  late List<Food> listMeat = [];
  late List<Food> listDrink = [];
  late List<Food> listDessert = [];

  @override
  void initState() {
    super.initState();
    listBurguer.addAll(
        widget.listFood.where((element) => element.isBurguer).toList());
    listSalad.addAll(
        widget.listFood.where((element) => element.isSalad).toList());
    listFish
        .addAll(widget.listFood.where((element) => element.isFish).toList());
    listMeat
        .addAll(widget.listFood.where((element) => element.isMeat).toList());
    listDrink.addAll(
        widget.listFood.where((element) => element.isDrink).toList());
    listDessert.addAll(
        widget.listFood.where((element) => element.isDessert).toList());
    checkList(listBurguer);
    checkList(listSalad);
    checkList(listFish);
    checkList(listMeat);
    checkList(listDrink);
    checkList(listDessert);
    orderAllList(!widget.changeIconPrice);
  }

  void checkList(List<Food> lista) {
    if (lista.isNotEmpty) {
      cant = cant + 1;
    }
  }

  void updateState() {
    setState(() {});
  }

  void orderAllList(bool control) {
    setState(() {
      orderList(listBurguer, control);
      orderList(listSalad, control);
      orderList(listFish, control);
      orderList(listMeat, control);
      orderList(listDrink, control);
      orderList(listDessert, control);
    });
  }

  void orderList(List<Food> lista, bool control) {
    if (control) {
      lista.sort(
        (a, b) => a.price.compareTo(b.price),
      );
    } else {
      lista.sort(
        (a, b) => b.price.compareTo(a.price),
      );
    }
  }

  void resetBurger(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = listBurguer.isEmpty;
      listBurguer.clear();
      listBurguer.addAll(widget.listFood
          .where((element) =>
              element.isBurguer && listNameFood.contains(element.name))
          .toList());
      if (listBurguer.isEmpty) {
        if (!control) {
          cant = cant - 1;
        }
      } else {
        if (control) {
          cant = cant + 1;
        }
      }
    });
  }

  void resetSalad(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = listSalad.isEmpty;
      listSalad.clear();
      listSalad.addAll(widget.listFood
          .where((element) =>
              element.isSalad && listNameFood.contains(element.name))
          .toList());
      if (listSalad.isEmpty) {
        if (!control) {
          cant = cant - 1;
        }
      } else {
        if (control) {
          cant = cant + 1;
        }
      }
    });
  }

  void resetFish(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = listFish.isEmpty;
      listFish.clear();
      listFish.addAll(widget.listFood
          .where((element) =>
              element.isFish && listNameFood.contains(element.name))
          .toList());
      if (listFish.isEmpty) {
        if (!control) {
          cant = cant - 1;
        }
      } else {
        if (control) {
          cant = cant + 1;
        }
      }
    });
  }

  void resetMeat(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = listMeat.isEmpty;
      listMeat.clear();
      listMeat.addAll(widget.listFood
          .where((element) =>
              element.isMeat && listNameFood.contains(element.name))
          .toList());
      if (listMeat.isEmpty) {
        if (!control) {
          cant = cant - 1;
        }
      } else {
        if (control) {
          cant = cant + 1;
        }
      }
    });
  }

  void resetDrink(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = listDrink.isEmpty;
      listDrink.clear();
      listDrink.addAll(widget.listFood
          .where((element) =>
              element.isDrink && listNameFood.contains(element.name))
          .toList());
      if (listDrink.isEmpty) {
        if (!control) {
          cant = cant - 1;
        }
      } else {
        if (control) {
          cant = cant + 1;
        }
      }
    });
  }

  void resetDessert(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = listDessert.isEmpty;
      listDessert.clear();
      listDessert.addAll(widget.listFood
          .where((element) =>
              element.isDessert && listNameFood.contains(element.name))
          .toList());
      if (listDessert.isEmpty) {
        if (!control) {
          cant = cant - 1;
        }
      } else {
        if (control) {
          cant = cant + 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: cant,
      child: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Container(
              width: widget.size.width,
              alignment: Alignment.center,
              child: Text(
                widget.language.dataJson[widget.language.positionLanguage]
                    ["Especial"],
                style: const TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )),
        ),
        body: Column(
          children: [
            Container(
              width: widget.size.width,
              color: Colors.orange,
              child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 6,
                  dividerColor: Colors.orange,
                  tabs: [
                    if (listBurguer.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Burguer.svg",
                          width: 35,
                        ),
                      ),
                    if (listSalad.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Salad.svg",
                          width: 35,
                        ),
                      ),
                    if (listFish.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Fish.svg",
                          width: 35,
                        ),
                      ),
                    if (listMeat.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Meat.svg",
                          width: 35,
                        ),
                      ),
                    if (listDrink.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Drink.svg",
                          width: 35,
                        ),
                      ),
                    if (listDessert.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Postre.svg",
                          width: 35,
                        ),
                      ),
                  ]),
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.darken),
                          image: const AssetImage(
                              "assets/images/fondoEspecial.webp"))),
                  child: cant == 0
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "Elige tu producto favorito",
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            Lottie.asset('assets/json/add.json')
                          ],
                        )
                      : TabBarView(children: [
                          if (listBurguer.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: listBurguer,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: resetBurger,
                              updateState: updateState,
                            ),
                          if (listSalad.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: listSalad,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: resetSalad,
                              updateState: updateState,
                            ),
                          if (listFish.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: listFish,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: resetFish,
                              updateState: updateState,
                            ),
                          if (listMeat.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: listMeat,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: resetMeat,
                              updateState: updateState,
                            ),
                          if (listDrink.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: listDrink,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: resetDrink,
                              updateState: updateState,
                            ),
                          if (listDessert.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: listDessert,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: resetDessert,
                              updateState: updateState,
                            ),
                        ])),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {
              widget.function();
              orderAllList(widget.changeIconPrice);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.changeIconPrice
                    ? const Icon(
                        Icons.arrow_upward,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.arrow_downward,
                        color: Colors.black,
                      ),
                Text(
                  widget.coin.symbol,
                  style: TextStyle(
                      fontSize: widget.size.width * 0.06, color: Colors.black),
                ),
              ],
            )),
      ),
    );
  }
}
