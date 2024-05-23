import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tfgsaladillo/models/Language.dart';
import '../../models/Food.dart';
import '../../models/Coin.dart';
import '../../models/Person.dart';
import '../widget/specialViewWidget.dart';

class EspecialView extends StatefulWidget {
  final Language idioma;
  final Size size;
  final List<Food> listaComida;
  final Coin monedaEnUso;
  final Function function;
  bool cambioIconoPrecio;
  Person person;

  EspecialView(
      {super.key,
      required this.size,
      required this.idioma,
      required this.listaComida,
      required this.monedaEnUso,
      required this.cambioIconoPrecio,
      required this.function,
      required this.person});

  @override
  State<EspecialView> createState() => _EspecialView();
}

class _EspecialView extends State<EspecialView> {
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
        widget.listaComida.where((element) => element.isEnsalada).toList());
    listaPescado.addAll(
        widget.listaComida.where((element) => element.isPescado).toList());
    listaCarne.addAll(
        widget.listaComida.where((element) => element.isCarne).toList());
    listaBebida.addAll(
        widget.listaComida.where((element) => element.isBebida).toList());
    listaPostre.addAll(
        widget.listaComida.where((element) => element.isPostre).toList());
    comprobarLista(listaBurguer);
    comprobarLista(listaEnsalada);
    comprobarLista(listaPescado);
    comprobarLista(listaCarne);
    comprobarLista(listaBebida);
    comprobarLista(listaPostre);
    orderAllList(!widget.cambioIconoPrecio);
  }

  void comprobarLista(List<Food> lista) {
    if (lista.isNotEmpty) {
      cant = cant + 1;
    }
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
        (a, b) => a.precio.compareTo(b.precio),
      );
    } else {
      lista.sort(
        (a, b) => b.precio.compareTo(a.precio),
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
              element.isBurguer && listNameFood.contains(element.nombre))
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
              element.isEnsalada && listNameFood.contains(element.nombre))
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
              element.isPescado && listNameFood.contains(element.nombre))
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
              element.isCarne && listNameFood.contains(element.nombre))
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
              element.isBebida && listNameFood.contains(element.nombre))
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
              element.isPostre && listNameFood.contains(element.nombre))
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
                widget.idioma.datosJson[widget.idioma.positionIdioma]
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
                      ),
                    if (listaEnsalada.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaEnsalada,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetSalad,
                      ),
                    if (listaPescado.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaPescado,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetFish,
                      ),
                    if (listaCarne.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaCarne,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetMeat,
                      ),
                    if (listaBebida.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaBebida,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetDrink,
                      ),
                    if (listaPostre.isNotEmpty)
                      ShowList(
                        size: widget.size,
                        listaComida: listaPostre,
                        monedaEnUso: widget.monedaEnUso,
                        idioma: widget.idioma,
                        person: widget.person,
                        anadirQuitarProducto: resetDessert,
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
                  widget.monedaEnUso.simbolo,
                  style: TextStyle(
                      fontSize: widget.size.width * 0.06, color: Colors.black),
                ),
              ],
            )),
      ),
    );
  }
}
