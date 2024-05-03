import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/PageFood.dart';

class ListaComida extends StatefulWidget {
  final List<Comida> listaComida;
  final String imagenBanner;
  final String nombreLista;
  final Idioma idioma;
  Moneda monedEnUso;
  ListaComida(
      {super.key,
      required this.listaComida,
      required this.imagenBanner,
      required this.monedEnUso,
      required this.idioma,
      required this.nombreLista});
  @override
  State<StatefulWidget> createState() => _ListaComida();
}

@immutable
class _ListaComida extends State<ListaComida> {
  final controller = ScrollController();

  void onListenerController() {
    setState(() {});
  }

  @override
  void initState() {
    controller.addListener(onListenerController);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onListenerController);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                        Colors.black,
                        Colors.black
                      ]).createShader(bounds),
              blendMode: BlendMode.darken,
              child: Container(
                width: size.width,
                height: size.height * 0.28,
                padding: EdgeInsets.only(
                    top: size.height * 0.120,
                    left: size.height * 0.05,
                    right: size.height * 0.05),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: Colors.black12,
                    image: DecorationImage(
                        image: AssetImage(widget.imagenBanner),
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.black38, BlendMode.lighten))),
                child: AutoSizeText(
                  widget.nombreLista,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: AutofillHints.jobTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: 60),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              )),
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.25, bottom: size.height * 0.01),
            color: Colors.black87,
            child: ListView.builder(
              controller: controller,
              itemCount: widget.listaComida.length,
              itemBuilder: (context, index) {
                final difference=controller.offset-(index*size.height*0.169);
                final percent= 1-(difference/(size.height*0.15));
                double opacity = percent;
                if(opacity>1.0) opacity = 1.0;
                if(opacity<0.0) opacity = 0.0;
                return Opacity(
                    opacity: opacity,
                  child:  Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..scale(opacity,opacity),
                    child:   BannerComida(
                      comida: widget.listaComida[index],
                      monedaEnUso: widget.monedEnUso,
                      idioma: widget.idioma,
                    )
                  )
                
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BotonVolver(),
    );
  }
}
class BannerComida extends StatelessWidget {
  final Comida comida;
  final Moneda monedaEnUso;
  final Idioma idioma;
  const BannerComida(
      {super.key,
      required this.comida,
      required this.monedaEnUso,
      required this.idioma});
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
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
          margin:  EdgeInsets.symmetric(horizontal:  size.width*0.05,vertical: size.height*0.01),
          width: double.infinity,
          height: size.height*0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(comida.foto),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.45), BlendMode.srcATop)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                  AutoSizeText(
                    maxLines: 1,
                    comida.nombre,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: AutoSizeText(
                          "${idioma.datosJson[idioma.positionIdioma]["Precio"]}: ${(comida.precio * monedaEnUso.conversor).toStringAsFixed(2)} ${monedaEnUso.simbolo}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                      )),
                      Expanded(
                          child: Center(
                        child: AutoSizeText(
                          maxLines: 1,
                          "${comida.tiempoMinuto} ${idioma.datosJson[idioma.positionIdioma]["Minuto"]}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                        ),
                      )),
                ],
              )
            ],
          )),
    );
  }
}
