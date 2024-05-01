import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';

class PaginaComida extends StatefulWidget{
  final Comida comida;
  final Idioma idioma;
  final Moneda monedaEnUso;
  const PaginaComida({super.key, required this.comida,required this.idioma,required this.monedaEnUso});
  @override
  State<StatefulWidget> createState() =>_PaginaComida();
}
class _PaginaComida extends State<PaginaComida>{
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      body:  Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    width: size.width,
                    child:
                    ShaderMask(
                        shaderCallback: (bounds) => const  LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            stops:[0.4,0.9],
                            colors: [
                              Colors.transparent,
                              Colors.black
                            ]).createShader(bounds),
                        blendMode: BlendMode.darken,
                        child:
                        Container(
                          width: size.width,
                          height: size.height*0.41,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: AssetImage(widget.comida.foto),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  isAntiAlias: true)),

                        )
                    )), Container(
                  width: size.width,
                  height: size.height,
                  margin: EdgeInsets.only(top: size.height*0.35),
                  decoration: const  BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                    image: DecorationImage(
                      image: AssetImage("assets/images/fondoSuelo.webp"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black38,BlendMode.darken)
                    )
                  ),
                  child:   SingleChildScrollView(
                      child: Column(
                        children: [
                              Container(
                                  margin: EdgeInsets.only(left: size.width*0.1,top: size.height*0.05,right:  size.width*0.1),
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(widget.comida.nombre,style: const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),maxLines: 1,)
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: size.width*0.1,top: size.height*0.02),
                                  alignment: Alignment.centerLeft,
                                  child: Text("${widget.idioma.datosJson[widget.idioma.positionIdioma]["Precio"]}: ${(widget.comida.precio * widget.monedaEnUso.conversor).toStringAsFixed(2)} ${widget.monedaEnUso.simbolo}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    textAlign: TextAlign.left,
                                  ),),
                        ],
                      )
                  ),
                
                ),
              ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            elevation: 10,
            backgroundColor: Colors.orange,
            child: const Icon(FontAwesomeIcons.arrowLeft),
          ),
    );
  }

}
