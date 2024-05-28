import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tfgsaladillo/models/Language.dart';

import '../../models/Coin.dart';
import '../../models/Food.dart';
import '../../models/Person.dart';
import '../widget/specialViewWidget.dart';

class SpecialView extends StatefulWidget {
  final Language idioma;
  final Size size;
  final List<Food> listaComida;
  final Coin monedaEnUso;
  final Function function;
  bool cambioIconoPrecio;
  Person person;

  SpecialView(
      {super.key,
      required this.size,
      required this.idioma,
      required this.listaComida,
      required this.monedaEnUso,
      required this.cambioIconoPrecio,
      required this.function,
      required this.person});

  @override
  State<SpecialView> createState() => _EspecialView();
}

class _EspecialView extends State<SpecialView> {
  late int cant = 0;
  late List<Food> listaBurguer = [];
  late List<Food> listaEnsalada = [];
  late List<Food> listaPescado = [];
  late List<Food> listaCarne = [];
  late List<Food> listaBebida = [];
  late List<Food> listaPostre = [];

  @override
  void initState() {
    super.initState();
    listaBurguer.addAll(
        widget.listaComida.where((element) => element.isBurguer).toList());
    listaEnsalada.addAll(
        widget.listaComida.where((element) => element.isSalad).toList());
    listaPescado.addAll(
        widget.listaComida.where((element) => element.isFish).toList());
    listaCarne.addAll(
        widget.listaComida.where((element) => element.isMeat).toList());
    listaBebida.addAll(
        widget.listaComida.where((element) => element.isDrink).toList());
    listaPostre.addAll(
        widget.listaComida.where((element) => element.isDessert).toList());
    checkList(listaBurguer);
    checkList(listaEnsalada);
    checkList(listaPescado);
    checkList(listaCarne);
    checkList(listaBebida);
    checkList(listaPostre);
    orderAllList(!widget.cambioIconoPrecio);
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
      orderList(listaBurguer, control);
      orderList(listaEnsalada, control);
      orderList(listaPescado, control);
      orderList(listaCarne, control);
      orderList(listaBebida, control);
      orderList(listaPostre, control);
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
      control = listaBurguer.isEmpty;
      listaBurguer.clear();
      listaBurguer.addAll(widget.listaComida
          .where((element) =>
              element.isBurguer && listNameFood.contains(element.name))
          .toList());
      if (listaBurguer.isEmpty) {
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
      control = listaEnsalada.isEmpty;
      listaEnsalada.clear();
      listaEnsalada.addAll(widget.listaComida
          .where((element) =>
              element.isSalad && listNameFood.contains(element.name))
          .toList());
      if (listaEnsalada.isEmpty) {
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
      control = listaPescado.isEmpty;
      listaPescado.clear();
      listaPescado.addAll(widget.listaComida
          .where((element) =>
              element.isFish && listNameFood.contains(element.name))
          .toList());
      if (listaPescado.isEmpty) {
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
      control = listaCarne.isEmpty;
      listaCarne.clear();
      listaCarne.addAll(widget.listaComida
          .where((element) =>
              element.isMeat && listNameFood.contains(element.name))
          .toList());
      if (listaCarne.isEmpty) {
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
      control = listaBebida.isEmpty;
      listaBebida.clear();
      listaBebida.addAll(widget.listaComida
          .where((element) =>
              element.isDrink && listNameFood.contains(element.name))
          .toList());
      if (listaBebida.isEmpty) {
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
      control = listaPostre.isEmpty;
      listaPostre.clear();
      listaPostre.addAll(widget.listaComida
          .where((element) =>
              element.isDessert && listNameFood.contains(element.name))
          .toList());
      if (listaPostre.isEmpty) {
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
                widget.idioma.dataJson[widget.idioma.positionLanguage]
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
                    if (listaBurguer.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Burguer.svg",
                          width: 35,
                        ),
                      ),
                    if (listaEnsalada.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Salad.svg",
                          width: 35,
                        ),
                      ),
                    if (listaPescado.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Fish.svg",
                          width: 35,
                        ),
                      ),
                    if (listaCarne.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Meat.svg",
                          width: 35,
                        ),
                      ),
                    if (listaBebida.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Drink.svg",
                          width: 35,
                        ),
                      ),
                    if (listaPostre.isNotEmpty)
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
                  child: TabBarView(children: [
                    if (listaBurguer.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaBurguer,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetBurger,
                        updateState: updateState,
                      ),
                    if (listaEnsalada.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaEnsalada,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetSalad,
                        updateState: updateState,
                      ),
                    if (listaPescado.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaPescado,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetFish,
                        updateState: updateState,
                      ),
                    if (listaCarne.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaCarne,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetMeat,
                        updateState: updateState,
                      ),
                    if (listaBebida.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaBebida,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetDrink,
                        updateState: updateState,
                      ),
                    if (listaPostre.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaPostre,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetDessert,
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
              orderAllList(widget.cambioIconoPrecio);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.cambioIconoPrecio
                    ? const Icon(
                        Icons.arrow_upward,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.arrow_downward,
                        color: Colors.black,
                      ),
                Text(
                  widget.monedaEnUso.symbol,
                  style: TextStyle(
                      fontSize: widget.size.width * 0.06, color: Colors.black),
                ),
              ],
            )),
      ),
    );
  }
}
