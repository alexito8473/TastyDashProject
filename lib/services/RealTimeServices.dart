import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Food.dart';
import '../models/Person.dart';
import '../models/Review.dart';
import '../utils/Constant.dart';
import 'AuthServices.dart';

class RealTimeService {
  static Future<Person?> checkAndGetUserData(
      String email, String password, SharedPreferences pref) async {
    Person? person;
    DatabaseReference date = FirebaseDatabase.instance.ref();
    if (await AuthService.sigInAuth(email, password)) {
      person = await getUserData(email, date);
      await pref.setString(Constant.SharedPreferences_MAIL, person.gmail);
    }
    return person;
  }

  static Future<void> updateListFoodUser(Person person) async {
    DatabaseReference date = FirebaseDatabase.instance.ref();
    await date
        .child(
            "Person/${person.gmail.trim().split("@")[0].toLowerCase()}/listaComida")
        .set(person.listFood!);
  }

  static Future<Person?> setUserData(String name, String email, String password,
      SharedPreferences pref) async {
    Person? person;
    DatabaseReference date = FirebaseDatabase.instance.ref();
    if (await AuthService.registerAuth(email, password)) {
      await date
          .child("Person/${email.trim().split("@")[0].toLowerCase()}")
          .set({
        "Nombre": name,
        "Gmail": email,
        "listaComida": [""]
      });
      person = Person(name: name, gmail: email, listFood: []);
      await pref.setString(Constant.SharedPreferences_MAIL, person.gmail);
    }
    return person;
  }

  static Future<Person> getUserData(
      String email, DatabaseReference date) async {
    List listFood = [];
    final snapshot = await date
        .child("Person/${email.trim().split("@")[0].toLowerCase()}/Nombre")
        .get();
    final listFoodFinal = await date
        .child("Person/${email.trim().split("@")[0].toLowerCase()}/listaComida")
        .get();
    if (listFoodFinal.value is List<dynamic>) {
      listFood.addAll(listFoodFinal.value as List<dynamic>);
    }
    return Person(
        name: snapshot.value.toString(),
        gmail: email,
        listFood: listFoodFinal.value is List<dynamic> ? listFood : []);
  }

  static Future<List<Food>> extractFoodList() async {
    DataSnapshot snapshot =
        await (FirebaseDatabase.instance.ref().child("Food/")).get();

    List<Food> listFood = [];
    int countFood = (snapshot.value as List).length;
    for (int i = 0; i < countFood; i++) {
      listFood.add(Food(
        id: i,
        name: snapshot.child("$i/name").value as String,
        pathImage: snapshot.child("$i/pathImage").value as String,
        isMeat: snapshot.child("$i/isMeat").value as bool,
        isBurguer: snapshot.child("$i/isBurguer").value as bool,
        isSalad: snapshot.child("$i/isSalad").value as bool,
        isDessert: snapshot.child("$i/isDessert").value as bool,
        isFish: snapshot.child("$i/isFish").value as bool,
        isDrink: snapshot.child("$i/isDrink").value as bool,
        price: double.parse(snapshot.child("$i/price").value.toString()),
        timeMinute: snapshot.child("$i/timeMinute").value as int,
        haveCelery: snapshot.child("$i/haveCelery").value as bool,
        haveMollusks: snapshot.child("$i/haveMollusks").value as bool,
        haveCrustaceans: snapshot.child("$i/haveCrustaceans").value as bool,
        haveMustard: snapshot.child("$i/haveMustard").value as bool,
        haveEgg: snapshot.child("$i/haveEgg").value as bool,
        haveFish: snapshot.child("$i/haveFish").value as bool,
        havePeanuts: snapshot.child("$i/havePeanuts").value as bool,
        haveGluten: snapshot.child("$i/haveGluten").value as bool,
        haveMilk: snapshot.child("$i/haveMilk").value as bool,
        haveSulfur: snapshot.child("$i/haveSulfur").value as bool,
        assessment:
            double.parse(snapshot.child("$i/assessment").value.toString()),
        amountAssessment:
            int.parse(snapshot.child("$i/amountAssessment").value.toString()),
        ingredients: snapshot.child("$i/ingredients").value == null
            ? []
            : snapshot.child("$i/ingredients").value as List<dynamic>,
        listReview: _extractReviewList(snapshot.child("$i/listReview")),
      ));
    }
    print(listFood);
    return listFood;
  }

  static List<Review> _extractReviewList(DataSnapshot dataReview) {
    List<Review> listReview = [];
    int cant = (dataReview.value as List<dynamic>).length;
    for (int i = 0; i < cant; i++) {
      listReview.add(Review(
          author: dataReview.child("$i/author").value as String,
          publication: DateTime.parse(
              dataReview.child("$i/publication").value as String),
          rating: double.parse(dataReview.child("$i/rating").value.toString()),
          content: dataReview.child("$i/context").value as String));
    }
    listReview.removeWhere((element) => element.content == "");
    return listReview;
  }

  static Future<List<Review>> getLastReviewList(Food food) async {
    return _extractReviewList(await (FirebaseDatabase.instance
            .ref()
            .child("Food/${food.id}/listReview"))
        .get());
  }

  static Future<void> addReview(Food food, Review review) async {
    DatabaseReference date =
        FirebaseDatabase.instance.ref().child("Food/${food.id}/");
    await date
        .child("listReview/${food.listReview.length-1}/author")
        .set(review.author);
    await date
        .child("listReview/${food.listReview.length-1}/context")
        .set(review.content);
    await date
        .child("listReview/${food.listReview.length-1}/rating")
        .set(review.rating);
    await date
        .child("listReview/${food.listReview.length}/publication")
        .set(review.publication.toIso8601String());
    await date.child("assessment").set(
        double.parse((await date.child("assessment").get()).value.toString()) +
            review.rating);
    await date.child("amountAssessment").set(int.parse(
            (await date.child("amountAssessment").get()).value.toString()) +
        1);
  }
}
