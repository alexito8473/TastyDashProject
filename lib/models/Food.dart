import 'Review.dart';

// Clase que representa un alimento
class Food {
  // Propiedades finales que no cambiarán después de ser inicializadas
  final int id;                // Identificador único del alimento
  final String name;           // Nombre del alimento
  final String pathImage;      // Ruta de la imagen del alimento
  final int timeMinute;        // Tiempo de preparación en minutos
  final bool isMeat;           // Indica si el alimento es carne
  final bool isBurguer;        // Indica si el alimento es una hamburguesa
  final bool isSalad;          // Indica si el alimento es una ensalada
  final bool isDessert;        // Indica si el alimento es un postre
  final bool isFish;           // Indica si el alimento es pescado
  final bool isDrink;          // Indica si el alimento es una bebida
  final bool haveCelery;       // Indica si el alimento contiene apio
  final bool haveMollusks;     // Indica si el alimento contiene moluscos
  final bool haveCrustaceans;  // Indica si el alimento contiene crustáceos
  final bool haveMustard;      // Indica si el alimento contiene mostaza
  final bool haveEgg;          // Indica si el alimento contiene huevo
  final bool haveFish;         // Indica si el alimento contiene pescado
  final bool havePeanuts;      // Indica si el alimento contiene cacahuetes
  final bool haveGluten;       // Indica si el alimento contiene gluten
  final bool haveMilk;         // Indica si el alimento contiene leche
  final bool haveSulfur;       // Indica si el alimento contiene azufre
  final List<dynamic> ingredients;  // Lista de ingredientes del alimento
  final double price;          // Precio del alimento

  // Propiedades que pueden cambiar después de ser inicializadas
  int amountAssessment;        // Cantidad de valoraciones del alimento
  double assessment;           // Valoración promedio del alimento
  List<Review> listReview;     // Lista de reseñas del alimento

  // Constructor de la clase `Food`
  Food({
    required this.id,
    required this.name,
    required this.pathImage,
    required this.isMeat,
    required this.isBurguer,
    required this.isSalad,
    required this.isDessert,
    required this.isFish,
    required this.isDrink,
    required this.price,
    required this.timeMinute,
    required this.haveCelery,
    required this.haveMollusks,
    required this.haveCrustaceans,
    required this.haveMustard,
    required this.haveEgg,
    required this.haveFish,
    required this.havePeanuts,
    required this.haveGluten,
    required this.haveMilk,
    required this.haveSulfur,
    required this.ingredients,
    this.assessment = 0,         // Valoración inicial por defecto es 0
    this.amountAssessment = 0,   // Cantidad de valoraciones inicial por defecto es 0
    required this.listReview     // Lista de reseñas del alimento
  });
}

