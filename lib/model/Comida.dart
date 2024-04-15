import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 10,
                  child:  RatingBar(

                    minRating: 0,
                    maxRating: 4,
                    initialRating: 2,
                    onRatingUpdate: (double value) {  },
                    ratingWidget: RatingWidget(full: Icon(Icons.star,weight: 0.1,color: Colors.orange), half:Icon(Icons.star,weight: 0.1,), empty: Icon(Icons.star,weight: 0.1,)),

                  )
                ),

              ],
            ))
    );
  }

}