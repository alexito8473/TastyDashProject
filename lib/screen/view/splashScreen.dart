import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/view/home.dart';
import '../../models/Food.dart';
import '../../services/RealTimeServices.dart';
import '../../utils/LoadImagesFoodCache.dart';
import '../../utils/Readjson.dart';
import '../widget/genericWidget.dart';
import '../widget/homeWidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    List<Food> listFood = createListFood();
    Person? person;
    BitmapDescriptor icon;
    String? gmail;
    Future.delayed(const Duration(milliseconds: 0), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List dataJson = await readJson();
      LoadImageInCache.loadImagesApplication(context);
      LoadImageInCache.loadImagesListFood(context, listFood);
      if ((gmail = prefs.getString("Gmail")) == null) {
        person = null;
        prefs.remove("Gmail");
      } else {
        person = await RealTimeService.getUserData(
            gmail!, FirebaseDatabase.instance.ref());
      }
      icon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), "assets/images/ic_map.webp");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    person: person,
                    lenguage: selectLanguage(prefs.getInt("Idioma"),dataJson),
                    prefs: prefs,
                    icon: icon,
                    coin: devolverTipoMoneda(prefs.getString("SimboloMoneda")),
                    initialPosition: 0,
                    listFood: createListFood(),
                  )),
          (route) => false);
    });
  }

  Language selectLanguage(int? position, List dataJson) {
    if (position == null) {
      return Language(datosJson: dataJson, positionIdioma: 0);
    } else {
      if (position >= 0 && position <= 1) {
        return Language(datosJson: dataJson, positionIdioma: position);
      } else {
        return Language(datosJson: dataJson, positionIdioma: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Background(asset: "assets/images/screen.webp"),
        const Center(
            child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Tasty Dash",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
                textAlign: TextAlign.end,
              ),
              Text(
                "By Alejandro Aguilar",
                style: TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.end,
              )
            ],
          ),
        )),
        Center(
            child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
          child: const Column(
            children: [
              CircularProgressIndicator(
                color: Colors.white,
                strokeAlign: 1.5,
                strokeWidth: 8,
              )
            ],
          ),
        ))
      ]),
    );
  }
}
