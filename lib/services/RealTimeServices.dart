import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Person.dart';
import 'AuthServices.dart';

class RealTimeService {
  static Future<Person?> checkAndGetUserData(
      String email, String password, SharedPreferences pref) async {
    Person? person;
    DatabaseReference date = FirebaseDatabase.instance.ref();
    if (await AuthService.sigInAuth(email, password)) {
      person = await getUserData(email, date);
      await pref.setString("Gmail", person.gmail);
    }
    return person;
  }

  static Future<void> updateListFoodUser(Person person) async {
    Person? person;
    DatabaseReference date = FirebaseDatabase.instance.ref();
    await date
        .child(
            "Person/${person!.gmail.trim().split("@")[0].toLowerCase()}/listaComida")
        .set(person!.listFood!);
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
      await pref.setString("Gmail", person.gmail);
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
}
