import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comida{
  final String nombre;
  String descripcion;
  final String foto;
  final bool isCarne;
  final bool isBurguer;
  final bool isEnsalada;
  final bool isPizza;
  final bool isPescado;
  final bool isSuchi;
  Comida({
    required this.nombre,
    required this.foto,
    required this.descripcion,
    required this.isCarne,
    required this.isBurguer,
    required this.isEnsalada,
    required this.isPizza,
    required this.isPescado,
    required this.isSuchi});
}
class ComidaViewCarrusel extends StatelessWidget{
  final Comida comida;
  const ComidaViewCarrusel({super.key, required this.comida});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () => print("Tocado"),
        child: Container(
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
                          image: AssetImage(comida.foto),
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                          isAntiAlias: true)),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                ),
                SizedBox(
                  width: double.infinity,
                  child:  Text(
                    comida.nombre,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                )

              ],
            ))
    );
  }

}