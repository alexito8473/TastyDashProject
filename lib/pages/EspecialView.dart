import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import '../model/Comida.dart';
import '../model/Moneda.dart';
import 'PageFood.dart';

class EspecialView extends StatefulWidget {
  final Idioma idioma;
  final Size size;
  final List<Comida> listaComida;
  final Moneda monedaEnUso;
  final Function function;
  bool cambioIconoPrecio;
  EspecialView(
      {super.key,
      required this.size,
      required this.idioma,
      required this.listaComida,
      required this.monedaEnUso,
      required this.cambioIconoPrecio,
      required this.function});
  @override
  State<EspecialView> createState() => _EspecialView();
}

class _EspecialView extends State<EspecialView> {
  late int cantidad=0;
  late List<Comida> listaBurguer;
  late List<Comida> listaEnsalada;
  late List<Comida> listaPescado;
  late List<Comida> listaCarne;
  late List<Comida> listaBebida;
  late List<Comida> listaPostre;
  @override
  void initState() {
    super.initState();
    if(( listaBurguer =
        widget.listaComida.where((element) => element.isBurguer).toList()).isNotEmpty){
      cantidad=cantidad+1;
    }
    if(( listaEnsalada =
        widget.listaComida.where((element) => element.isEnsalada).toList()).isNotEmpty){
      cantidad=cantidad+1;
    }
    if(( listaPescado =
        widget.listaComida.where((element) => element.isPescado).toList()).isNotEmpty){
      cantidad=cantidad+1;
    }
    if(( listaCarne =
        widget.listaComida.where((element) => element.isCarne).toList()).isNotEmpty){
      cantidad=cantidad+1;
    }
    if(( listaBebida =
        widget.listaComida.where((element) => element.isBebida).toList()).isNotEmpty){
      cantidad=cantidad+1;
    }
    if(( listaPostre =
        widget.listaComida.where((element) => element.isPostre).toList()).isNotEmpty){
      cantidad=cantidad+1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // TabBar Hazlo ale
      width: widget.size.width,
      height: widget.size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.darken),
              image: const AssetImage("assets/images/fondoEspecial.webp"))),
      child: DefaultTabController(
        length: cantidad,
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
                      if(listaBurguer.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Burguer.svg",
                          width: 35,
                        ),
                      ),
                      if(listaEnsalada.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Salad.svg",
                          width: 35,
                        ),
                      ),
                      if(listaPescado.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Fish.svg",
                          width: 35,
                        ),
                      ),
                      if(listaCarne.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Meat.svg",
                          width: 35,
                        ),
                      ),
                      if(listaBebida.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Drink.svg",
                          width: 35,
                        ),
                      ),
                      if(listaPostre.isNotEmpty)
                      Tab(
                        icon: SvgPicture.asset(
                          "assets/Icons/Menu.svg",
                          width: 35,
                        ),
                      ),
                    ]),
              ),
              Expanded(
                  child: TabBarView(children: [
                    if(listaBurguer.isNotEmpty)
                MostrarLista(
                  size: widget.size,
                  listaComida: listaBurguer,
                  monedaEnUso: widget.monedaEnUso,
                  idioma: widget.idioma,
                ),
                    if(listaEnsalada.isNotEmpty)
                MostrarLista(
                  size: widget.size,
                  listaComida: listaEnsalada,
                  monedaEnUso: widget.monedaEnUso,
                  idioma: widget.idioma,
                ),
                    if(listaPescado.isNotEmpty)
                MostrarLista(
                  size: widget.size,
                  listaComida: listaPescado,
                  monedaEnUso: widget.monedaEnUso,
                  idioma: widget.idioma,
                ),
                    if(listaCarne.isNotEmpty)
                MostrarLista(
                  size: widget.size,
                  listaComida: listaCarne,
                  monedaEnUso: widget.monedaEnUso,
                  idioma: widget.idioma,
                ),
                    if(listaBebida.isNotEmpty)
                MostrarLista(
                  size: widget.size,
                  listaComida: listaBebida,
                  monedaEnUso: widget.monedaEnUso,
                  idioma: widget.idioma,
                ),
                    if(listaPostre.isNotEmpty)
                MostrarLista(
                  size: widget.size,
                  listaComida: listaPostre,
                  monedaEnUso: widget.monedaEnUso,
                  idioma: widget.idioma,
                ),
              ])),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              widget.function();
            },
            child: widget.cambioIconoPrecio
                ? Icon(Icons.arrow_upward)
                : Icon(Icons.arrow_downward),
          ),
        ),
      ),
    );
  }
}

class MostrarLista extends StatelessWidget {
  final Size size;
  final List<Comida> listaComida;
  final Moneda monedaEnUso;
  final Idioma idioma;
  const MostrarLista(
      {super.key,
      required this.size,
      required this.listaComida,
      required this.monedaEnUso,
      required this.idioma});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin:
          EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
      child: GridView.builder(
        itemCount: listaComida.length,
        itemBuilder: (context, index) {
          return BannerComidaGrid(
            comida: listaComida[index],
            monedaEnUso: monedaEnUso,
            idioma: idioma,
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
    );
  }
}

class BannerComidaGrid extends StatelessWidget {
  final Comida comida;
  final Moneda monedaEnUso;
  final Idioma idioma;
  const BannerComidaGrid(
      {super.key,
      required this.comida,
      required this.monedaEnUso,
      required this.idioma});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          barrierColor: Colors.black54,
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
                opacity: animation,
                child: PaginaComida(
                  comida: comida,
                  idioma: idioma,
                  monedaEnUso: monedaEnUso,
                ));
          },
        ));
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaginaComida(comida: comida),));
      },
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          height: size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(comida.foto),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55), BlendMode.srcATop)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                maxLines: 1,
                comida.nombre,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              AutoSizeText(
                "${idioma.datosJson[idioma.positionIdioma]["Precio"]}: ${(comida.precio * monedaEnUso.conversor).toStringAsFixed(2)} ${monedaEnUso.simbolo}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.left,
                maxLines: 1,
              ),
              AutoSizeText(
                maxLines: 1,
                "${comida.tiempoMinuto} ${idioma.datosJson[idioma.positionIdioma]["Minuto"]}",
                style: const TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.left,
              ),
            ],
          )),
    );
  }
}
