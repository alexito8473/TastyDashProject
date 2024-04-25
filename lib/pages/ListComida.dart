import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/PageFood.dart';

class ListaComida extends StatefulWidget {
  final List<Comida> listaComida;
  final String imagenBanner;
  final Idioma idioma;
  Moneda monedEnUso;
  ListaComida(
      {super.key,
        required this.listaComida,
      required this.imagenBanner,
      required this.monedEnUso,
        required this.idioma});
  @override
  State<StatefulWidget> createState() => _ListaComida();
}

@immutable
class _ListaComida extends State<ListaComida> {
  @override
  void initState() {
    super.initState();
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
                        Colors.black87,
                        Colors.black
                      ]).createShader(bounds),
              blendMode: BlendMode.darken,
              child: Container(
                width: size.width,
                height: size.height * 0.30,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: Colors.black12,
                    image: DecorationImage(
                        image: AssetImage(widget.imagenBanner),
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.black38, BlendMode.lighten)
                    )),
              )),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.28,bottom: size.height * 0.02),
            color: Colors.black87,
            child: ListView.builder(
              itemCount: widget.listaComida.length,
              itemBuilder: (context, index) {
                return BannerComida(
                  comida: widget.listaComida[index],
                  monedaEnUso: widget.monedEnUso,
                  idioma: widget.idioma,
                );
              },
            ),
          ),
          Positioned(
              top: size.height * 0.265,
              child: Container(
                width: size.width,
                height: size.height * 0.020,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:  BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        elevation: 20,
        backgroundColor: Colors.orange,
        child: const Icon(FontAwesomeIcons.arrowLeft),
      ),
    );
  }
}

class BannerComida extends StatelessWidget {
  final Comida comida;
  final Moneda monedaEnUso;
  final Idioma idioma;
  const BannerComida(
      {super.key, required this.comida, required this.monedaEnUso, required this.idioma});
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
                opacity: animation, child: PaginaComida(comida: comida));
          },
        ));
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaginaComida(comida: comida),));
      },
      child: Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(comida.foto),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.59), BlendMode.srcATop)),
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    child   : AutoSizeText(
            maxLines: 1,
            comida.nombre,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          "${(comida.precio * monedaEnUso.conversor).toStringAsFixed(2)} ${monedaEnUso.simbolo}",
                          style: const TextStyle(color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: AutoSizeText(
                          maxLines: 1,
                          "${(comida.precio * monedaEnUso.conversor).toStringAsFixed(2)} ${monedaEnUso.simbolo}",
                          style: const TextStyle(color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  )

                ],
              )
            ],
          )),
    );
  }
}
