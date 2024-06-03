import 'Review.dart';

class Food {
  final int id;
  final String name;
  final String pathImage;
  final int timeMinute;
  final bool isMeat;
  final bool isBurguer;
  final bool isSalad;
  final bool isDessert;
  final bool isFish;
  final bool isDrink;
  final bool haveCelery;
  final bool haveMollusks;
  final bool haveCrustaceans;
  final bool haveMustard;
  final bool haveEgg;
  final bool haveFish;
  final bool havePeanuts;
  final bool haveGluten;
  final bool haveMilk;
  final bool haveSulfur;
  final List<dynamic> ingredients;
  final double price;
  int amountAssessment;
  double assessment;
  List<Review> listReview;

  Food(
      {required this.id,
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
      this.assessment = 0,
      this.amountAssessment = 0,
      required this.listReview});
}
