import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
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

double conversorMoneda(double original){
  return 2.2;
}

class ComidaViewCarrusel extends StatefulWidget{
  final Comida comida;
  Moneda monedaEnUso;
  final Idioma idioma;
  ComidaViewCarrusel({super.key, required this.comida, required this.monedaEnUso,required this.idioma});
  @override
  State<StatefulWidget> createState() =>_ComidaViewCarrusel();
}

class _ComidaViewCarrusel extends State<ComidaViewCarrusel>{
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () =>{
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaginaComida(comida: widget.comida),))
          Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 600),
                reverseTransitionDuration: const Duration(milliseconds: 300),
                barrierColor: Colors.black54,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(opacity: animation,
                    child: PaginaComida(comida: widget.comida, idioma: widget.idioma, monedaEnUso: widget.monedaEnUso,),
                  );
                },
              ))
        } ,
        child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.91),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height*0.15,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(15),
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage(widget.comida.foto),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              isAntiAlias: true)),

                    ),
                    SizedBox(
                      width: double.infinity, height: size.height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [ Container(
                          width: double.infinity,
                          child: AutoSizeText(
                            widget.comida.nombre,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.black,fontSize: 25),
                            textAlign: TextAlign.left,
                          ),
                        ),
                          SizedBox(
                            width: double.infinity,
                            child: AutoSizeText("${widget.idioma.datosJson[widget.idioma.positionIdioma]["Precio"]}: ${(widget.comida.precio * widget.monedaEnUso.conversor).toStringAsFixed(2)} ${widget.monedaEnUso.simbolo}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 25),
                              textAlign: TextAlign.left,
                            ),
                          ),],
                      )
                    )
                  ],
                )
              )
            )

    );
  }
}
class BotonVolver extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: ()=>Navigator.pop(context),
        child: Container(
          height: size.height*0.06,
          width: size.width*0.14,
          margin: EdgeInsets.only(right: size.height*0.01,bottom: size.height*0.01),
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: const Icon(FontAwesomeIcons.arrowLeft,color: Colors.black,),
        ));
  }
}
List<Comida> CrearListaDeComida(){
  List<Comida> listaDeComida = [
    // Hamburguesa
    const Comida(
        nombre: 'BurguerMax',
        foto: 'assets/images/hamburguesa.webp',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 5.12,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
      haveAzufre: false,
      haveCacahuetes: false,
      haveGluten: false,
      haveHuevo: false,
      haveLeche: false,
      haveMostaza: false,
      havePescado: false
    ),
    const Comida(
        nombre: 'BurguerUltra',
        foto: 'assets/images/imagen.webp',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 4.12,
  tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Burguer Buey',
        foto: 'assets/images/haburguesaEspecial.webp',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 4.50,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Burguer Complete',
        foto: 'assets/images/hamburguesaCompleta.webp',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 4.50,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'The Ultimate Beef Burger',
        foto: 'assets/images/hamburguesaBueyBeiconPatatasFritas.webp',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 4.50,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Harmony Burger',
        foto: 'assets/images/hamburguesaPatatasFritas.webp',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 4.50,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Veggie Delight',
        foto: 'assets/images/hamburguesaVegana.jpg',
        isCarne: false,
        isBurguer: true,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 4.50,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    // Ensalada
    const Comida(
        nombre: 'Breaded pepper',
        foto: 'assets/images/piminetoRebo.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: true,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 5.99,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Shrimp Scampi',
        foto: 'assets/images/gambasAl.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: true,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Vegetable cream',
        foto: 'assets/images/cremaVerdura.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: true,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Vegetable taco',
        foto: 'assets/images/tacoVerdura.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: true,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    // Carne
    const Comida(
        nombre: 'Scnizel',
        foto: 'assets/images/schnitzel.webp',
        isCarne: true,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Iberic secret',
        foto: 'assets/images/secretoIberico.webp',
        isCarne: true,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Ragout',
        foto: 'assets/images/ragout.webp',
        isCarne: true,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Meat balls',
        foto: 'assets/images/albondiga.webp',
        isCarne: true,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Fillet',
        foto: 'assets/images/filete.webp',
        isCarne: true,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    // Pescado
    const Comida(
        nombre: 'Fried shrimp',
        foto: 'assets/images/camaronesFritos.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: true,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Tilapia',
        foto: 'assets/images/tilapia.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: true,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Octo-Bite',
        foto: 'assets/images/pulpoGallega.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: true,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Besugo',
        foto: 'assets/images/besugo.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: true,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Octo-Grilled',
        foto: 'assets/images/pulpoBrasa.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: true,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Octo-chips',
        foto: 'assets/images/pescadoPatatasFritas.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: true,
        isBebida: false,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    // Bebida
    const Comida(
        nombre: 'Coca cola',
        foto: 'assets/images/cocaCola.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: true,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Coca cola zero',
        foto: 'assets/images/cocaColaZero.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: true,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Fanta (Orange)',
        foto: 'assets/images/fantaNaranja.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: true,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
    const Comida(
        nombre: 'Fanta (Lemon)',
        foto: 'assets/images/fantaLimon.webp',
        isCarne: false,
        isBurguer: false,
        isEnsalada: false,
        isPostre: false,
        isPescado: false,
        isBebida: true,
        precio: 3.22,
        tiempoMinuto: 20,
      haveApio: false,
      haveCrustaceos: false,
      haveMoluscos: false,
        haveAzufre: false,
        haveCacahuetes: false,
        haveGluten: false,
        haveHuevo: false,
        haveLeche: false,
        haveMostaza: false,
        havePescado: false),
  ];
  return listaDeComida;
}