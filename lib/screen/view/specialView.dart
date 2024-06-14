import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/widget/specialViewWidget.dart';

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
  State<SpecialView> createState() => _SpecialViewState();
}

class _SpecialViewState extends State<SpecialView> {
  late int _cant = 0;
  late List<Food> _listBurguer = [];
  late List<Food> _listSalad = [];
  late List<Food> _listFish = [];
  late List<Food> _listMeat = [];
  late List<Food> _listDrink = [];
  late List<Food> _listDessert = [];

  @override
  void initState() {
    super.initState();
    _listBurguer.addAll(
        widget.listFood.where((element) => element.isBurguer).toList());
    _listSalad.addAll(
        widget.listFood.where((element) => element.isSalad).toList());
    _listFish
        .addAll(widget.listFood.where((element) => element.isFish).toList());
    _listMeat
        .addAll(widget.listFood.where((element) => element.isMeat).toList());
    _listDrink.addAll(
        widget.listFood.where((element) => element.isDrink).toList());
    _listDessert.addAll(
        widget.listFood.where((element) => element.isDessert).toList());
    _checkList(_listBurguer);
    _checkList(_listSalad);
    _checkList(_listFish);
    _checkList(_listMeat);
    _checkList(_listDrink);
    _checkList(_listDessert);
    _orderAllList(!widget.changeIconPrice);
  }

  void _checkList(List<Food> list) {
    if (list.isNotEmpty) {
      _cant = _cant + 1;
    }
  }

  void _updateState() {
    setState(() {});
  }

  void _orderAllList(bool control) {
    setState(() {
      _orderList(_listBurguer, control);
      _orderList(_listSalad, control);
      _orderList(_listFish, control);
      _orderList(_listMeat, control);
      _orderList(_listDrink, control);
      _orderList(_listDessert, control);
    });
  }

  void _orderList(List<Food> list, bool control) {
    if (control) {
      list.sort(
        (a, b) => a.price.compareTo(b.price),
      );
    } else {
      list.sort(
        (a, b) => b.price.compareTo(a.price),
      );
    }
  }

  void _resetBurger(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = _listBurguer.isEmpty;
      _listBurguer.clear();
      _listBurguer.addAll(widget.listFood
          .where((element) =>
              element.isBurguer && listNameFood.contains(element.name))
          .toList());
      if (_listBurguer.isEmpty) {
        if (!control) {
          _cant = _cant - 1;
        }
      } else {
        if (control) {
          _cant = _cant + 1;
        }
      }
    });
  }

  void _resetSalad(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = _listSalad.isEmpty;
      _listSalad.clear();
      _listSalad.addAll(widget.listFood
          .where((element) =>
              element.isSalad && listNameFood.contains(element.name))
          .toList());
      if (_listSalad.isEmpty) {
        if (!control) {
          _cant = _cant - 1;
        }
      } else {
        if (control) {
          _cant = _cant + 1;
        }
      }
    });
  }

  void _resetFish(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = _listFish.isEmpty;
      _listFish.clear();
      _listFish.addAll(widget.listFood
          .where((element) =>
              element.isFish && listNameFood.contains(element.name))
          .toList());
      if (_listFish.isEmpty) {
        if (!control) {
          _cant = _cant - 1;
        }
      } else {
        if (control) {
          _cant = _cant + 1;
        }
      }
    });
  }

  void _resetMeat(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = _listMeat.isEmpty;
      _listMeat.clear();
      _listMeat.addAll(widget.listFood
          .where((element) =>
              element.isMeat && listNameFood.contains(element.name))
          .toList());
      if (_listMeat.isEmpty) {
        if (!control) {
          _cant = _cant - 1;
        }
      } else {
        if (control) {
          _cant = _cant + 1;
        }
      }
    });
  }

  void _resetDrink(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = _listDrink.isEmpty;
      _listDrink.clear();
      _listDrink.addAll(widget.listFood
          .where((element) =>
              element.isDrink && listNameFood.contains(element.name))
          .toList());
      if (_listDrink.isEmpty) {
        if (!control) {
          _cant = _cant - 1;
        }
      } else {
        if (control) {
          _cant = _cant + 1;
        }
      }
    });
  }

  void _resetDessert(List<dynamic> listNameFood) {
    bool control;
    setState(() {
      control = _listDessert.isEmpty;
      _listDessert.clear();
      _listDessert.addAll(widget.listFood
          .where((element) =>
              element.isDessert && listNameFood.contains(element.name))
          .toList());
      if (_listDessert.isEmpty) {
        if (!control) {
          _cant = _cant - 1;
        }
      } else {
        if (control) {
          _cant = _cant + 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _cant,
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
                    if (_listBurguer.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Burguer.svg",
                          width: 35,
                        ),
                      ),
                    if (_listSalad.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Salad.svg",
                          width: 35,
                        ),
                      ),
                    if (_listFish.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Fish.svg",
                          width: 35,
                        ),
                      ),
                    if (_listMeat.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Meat.svg",
                          width: 35,
                        ),
                      ),
                    if (_listDrink.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Drink.svg",
                          width: 35,
                        ),
                      ),
                    if (_listDessert.isNotEmpty)
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
                  child: _cant == 0
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              widget.language.dataJson[widget.language.positionLanguage]["SPECIAL_VIEW_TEXT"],
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            Lottie.asset('assets/json/add.json')
                          ],
                        )
                      : TabBarView(children: [
                          if (_listBurguer.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: _listBurguer,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: _resetBurger,
                              updateState: _updateState,
                            ),
                          if (_listSalad.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: _listSalad,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: _resetSalad,
                              updateState: _updateState,
                            ),
                          if (_listFish.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: _listFish,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: _resetFish,
                              updateState: _updateState,
                            ),
                          if (_listMeat.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: _listMeat,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: _resetMeat,
                              updateState: _updateState,
                            ),
                          if (_listDrink.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: _listDrink,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: _resetDrink,
                              updateState: _updateState,
                            ),
                          if (_listDessert.isNotEmpty)
                            ShowList(
                              size: widget.size,
                              listFood: _listDessert,
                              coin: widget.coin,
                              language: widget.language,
                              person: widget.person,
                              addOrRemoveList: _resetDessert,
                              updateState: _updateState,
                            ),
                        ])),
            )
          ],
        ),
        floatingActionButton:_cant==0?null:  FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {
              widget.function();
              _orderAllList(widget.changeIconPrice);
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
