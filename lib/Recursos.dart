import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Comida.dart';

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
            color: Colors.white70, borderRadius: BorderRadius.circular(30)),
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

List<Comida> CrearListaDeComida(){
   List<Comida> listaDeComida = [
    Comida(
        nombre: 'BurguerMax',
        foto: 'assets/images/hamburguesa.webp',
        descripcion: 'Nada malo',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPizza: false,
        isPescado: false,
        isSuchi: false),
    Comida(
        nombre: 'BurguerUltra',
        foto: 'assets/images/imagen.webp',
        descripcion: 'Nada malo',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPizza: false,
        isPescado: false,
        isSuchi: false),
     Comida(
         nombre: 'Breaded pepper',
         foto: 'assets/images/piminetoRebo.webp',
         descripcion: 'Nada malo',
         isCarne: false,
         isBurguer: false,
         isEnsalada: true,
         isPizza: false,
         isPescado: false,
         isSuchi: false),
     Comida(
         nombre: 'Shrimp Scampi',
         foto: 'assets/images/gambasAl.webp',
         descripcion: 'Nada malo',
         isCarne: false,
         isBurguer: false,
         isEnsalada: false,
         isPizza: false,
         isPescado: false,
         isSuchi: false),
  ];
  return listaDeComida;
}
