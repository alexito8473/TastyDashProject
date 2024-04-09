
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Comida.dart';

class Carta extends StatefulWidget {
  List<Comida> listaDeComida;
  Carta( {super.key,required this.listaDeComida});
  @override
  State<StatefulWidget> createState() => _Carta();
}

class _Carta extends State<Carta> {
  late String imagenActual;
@override
  void initState() {
  imagenActual = widget.listaDeComida[0].foto;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          children: [
            ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent,Colors.transparent,Colors.transparent, Colors.white])
                    .createShader(bounds),
                blendMode: BlendMode.colorDodge,
                child: Container(
                  padding: const EdgeInsets.only(top: 140,bottom: 30),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imagenActual),
                            fit: BoxFit.cover)
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          pageSnapping: true,
                          height: size.height * 0.35,
                          initialPage: 0,
                          aspectRatio: 16 / 9,
                          disableCenter: false,
                          viewportFraction: 0.7,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 8),
                          autoPlayAnimationDuration:
                          const  Duration(milliseconds: 800),
                          autoPlayCurve: Curves.easeInCubic,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) =>setState(() {
                            print("hola");
                            imagenActual = widget.listaDeComida[index].foto;
                          }),
                          scrollDirection: Axis.horizontal),
                      items: widget.listaDeComida.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.89),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                              image: AssetImage(i.foto),
                                              fit: BoxFit.fill,
                                              alignment: Alignment.center,
                                              isAntiAlias: true)),
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child:  Text(
                                        i.nombre,
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.left,
                                      ),
                                    )

                                  ],
                                ));
                          },
                        );
                      }).toList(),
                    )))
          ],
        ),
      ),
    );
  }
}
