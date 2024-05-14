import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';

import '../../model/Person.dart';
import '../widget/genericWidget.dart';
import '../widget/listFoodWidget.dart';

class ListFood extends StatefulWidget {
  final List<Comida> listaComida;
  final String imagenBanner;
  final String nombreLista;
  final Idioma idioma;
  final Person? person;
  final Moneda monedEnUso;

  const ListFood(
      {super.key,
      required this.listaComida,
      required this.imagenBanner,
      required this.monedEnUso,
      required this.idioma,
      required this.nombreLista,
      required this.person});

  @override
  State<StatefulWidget> createState() => _ListFood();
}

@immutable
class _ListFood extends State<ListFood> {
  final controller = ScrollController();

  void onListenerController() {
    setState(() {});
  }

  void vacio(List list) {
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
                            Colors.black38, BlendMode.darken))),
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
                final difference =
                    controller.offset - (index * size.height * 0.169);
                final percent = 1 - (difference / (size.height * 0.15));
                double opacity = percent;
                if (opacity > 1.0) opacity = 1.0;
                if (opacity < 0.0) opacity = 0.0;
                return Opacity(
                    opacity: opacity,
                    child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..scale(opacity, opacity),
                        child: BannerComida(
                          comida: widget.listaComida[index],
                          monedaEnUso: widget.monedEnUso,
                          idioma: widget.idioma,
                          person: widget.person,
                          anadirQuitarProducto: vacio,
                        )));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const ButtonBack(),
    );
  }
}
