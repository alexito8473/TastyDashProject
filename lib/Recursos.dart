import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/PageFood.dart';

class Background extends StatefulWidget {
  final String asset;
  const Background({super.key, required this.asset});
  @override
  State<StatefulWidget> createState() => _Background();
}

class _Background extends State<Background> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.centerRight,
            colors: [Colors.black87, Colors.transparent]).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.asset),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.black38, BlendMode.darken)))));
  }
}



class TextFieldMio extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Size sizeContext;
  final IconData icono;
  final TextInputType textType;
  final TextInputAction action;
  final bool obscureText;
  const TextFieldMio(
      {super.key,
      required this.hint,
      required this.controller,
      required this.sizeContext,
      required this.icono,
      required this.textType,
      required this.action,
      required this.obscureText});
  @override
  State<StatefulWidget> createState() => _TextFielMio();
}

class _TextFielMio extends State<TextFieldMio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? widget.sizeContext.height * 0.06
            : widget.sizeContext.height * 0.11,
        width: widget.sizeContext.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white60, borderRadius: BorderRadius.circular(24)),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  widget.icono,
                  size: 30,
                  color: Colors.black,
                )),
            border: InputBorder.none,
            hintStyle: const TextStyle(fontWeight: FontWeight.bold),
            hintText: widget.hint,
          ),
          obscureText: widget.obscureText,
          keyboardType: widget.textType,
          textInputAction: widget.action,
        ),
      ),
    );
  }
}

void MensajeAlCliente(BuildContext context, String mensage, double font) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 1,
    width: 300.0,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.white70,
    duration: const Duration(milliseconds: 1100),
    content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Text(
          mensage,
          style: TextStyle(
              fontSize: font, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        )),
  ));
}

Future<List <dynamic>> leerListaJson(String json) async {
  final listaMap = jsonDecode(json);
  return listaMap;
}
List<String> CrearListaBanderas(){
  return ["assets/Icons/Spain.svg", "assets/Icons/England.svg"];
}
List<String> CrearListaPaises(){
  return ["Español", "English"];
}
List<Comida> CrearListaDeComida(){
   List<Comida> listaDeComida = [
    Comida(
        nombre: 'BurguerMax',
        foto: 'assets/images/hamburguesa.webp',
        descripcion: 'Mega burguer max',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPizza: false,
        isPescado: false,
        isSuchi: false,
        precio: 5.12),
    Comida(
        nombre: 'BurguerUltra',
        foto: 'assets/images/imagen.webp',
        descripcion: 'Burguer ultra maximo bum',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPizza: false,
        isPescado: false,
        isSuchi: false, 
        precio: 4.12),
     Comida(
         nombre: 'Burguer Buey',
         foto: 'assets/images/haburguesaEspecial.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Burguer Complete',
         foto: 'assets/images/hamburguesaCompleta.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Burguer Complete',
         foto: 'assets/images/hamburguesaCompleta.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Burguer Complete',
         foto: 'assets/images/hamburguesaCompleta.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Burguer Complete',
         foto: 'assets/images/hamburguesaCompleta.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Burguer Complete',
         foto: 'assets/images/hamburguesaCompleta.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Burguer Complete',
         foto: 'assets/images/hamburguesaCompleta.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Burguer Complete',
         foto: 'assets/images/hamburguesaCompleta.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Burguer Complete',
         foto: 'assets/images/hamburguesaCompleta.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: true,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 4.50),
     Comida(
         nombre: 'Breaded pepper',
         foto: 'assets/images/piminetoRebo.webp',
         descripcion: 'Comida rara',
         isCarne: false,
         isBurguer: false,
         isEnsalada: true,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 5.99),
     Comida(
         nombre: 'Shrimp Scampi',
         foto: 'assets/images/gambasAl.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: false,
         isEnsalada: true,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 3.22),
     Comida(
         nombre: 'Shrimp Scampi',
         foto: 'assets/images/gambasAl.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: false,
         isEnsalada: true,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 3.22),
     Comida(
         nombre: 'Shrimp Scampi',
         foto: 'assets/images/gambasAl.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: false,
         isEnsalada: true,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 3.22),
     Comida(
         nombre: 'Shrimp Scampi',
         foto: 'assets/images/gambasAl.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: false,
         isEnsalada: true,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 3.22),
     Comida(
         nombre: 'Shrimp Scampi',
         foto: 'assets/images/gambasAl.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: false,
         isEnsalada: true,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 3.22),
     Comida(
         nombre: 'Shrimp Scampi',
         foto: 'assets/images/gambasAl.webp',
         descripcion: 'Ratoncio',
         isCarne: false,
         isBurguer: false,
         isEnsalada: true,
         isPizza: false,
         isPescado: false,
         isSuchi: false,
         precio: 3.22),

  ];
  return listaDeComida;
}
double conversorMoneda(double original){
  return 2.2;
}

class ComidaViewCarrusel extends StatefulWidget{
  final Comida comida;
  Moneda monedEnUso;
  ComidaViewCarrusel({super.key, required this.comida, required this.monedEnUso});
  @override
  State<StatefulWidget> createState() =>_ComidaViewCarrusel();
}

class _ComidaViewCarrusel extends State<ComidaViewCarrusel>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaginaComida(comida: widget.comida),))
          /*
          Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 800),
                reverseTransitionDuration: const Duration(milliseconds: 800),
                barrierColor: Colors.black54,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(opacity: animation,
                    child: PaginaComida(comida: widget.comida),
                  );
                },
              ))
              */
        } ,
        child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.89),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                child:   Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(15),
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage(widget.comida.foto),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              isAntiAlias: true)),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: Text(
                        widget.comida.nombre,
                        style: const TextStyle(color: Colors.black,fontSize: 25),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: Text(
                        "${(widget.comida.precio*widget.monedEnUso.conversor).toStringAsFixed(2)} ${widget.monedEnUso.simbolo}",
                        style: const TextStyle(color: Colors.black,fontSize: 25),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                )
              )
            )

    );
  }
}