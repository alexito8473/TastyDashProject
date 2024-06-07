import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/view/home.dart';

import '../../models/Food.dart';
import '../../services/RealTimeServices.dart';
import '../../utils/Constant.dart';
import '../../utils/LoadImagesFoodCache.dart';
import '../../utils/Readjson.dart';
import '../widget/genericWidget.dart';
import 'errorView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Person? person;
    BitmapDescriptor icon;
    String? email;
    final Connectivity connectivity = Connectivity();
    Future.delayed(const Duration(milliseconds: 10), () async {
      Language? language;
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        List dataJson = await readJson();
        language = selectLanguage(
            prefs.getInt(Constant.SHARED_PREFERENCE_LANGUAGE), dataJson);
        List<ConnectivityResult> connectivityResult =
            await connectivity.checkConnectivity();
        if (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi) ||
            connectivityResult.contains(ConnectivityResult.ethernet)) {
          List dataJson = await readJson();
          List<Food> listFood = await RealTimeService.extractFoodList();
          await LoadImageInCache.loadImagesApplication(context);
          await LoadImageInCache.loadImagesListFood(context, listFood);
          if ((email = prefs.getString(Constant.SharedPreferences_MAIL)) ==
              null) {
            person = null;
            prefs.remove(Constant.SharedPreferences_MAIL);
          } else {
            person = await RealTimeService.getUserData(
                email!, FirebaseDatabase.instance.ref());
          }
          icon = await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/ic_map.webp");

          await Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: HomePage(
                  person: person,
                  language: selectLanguage(
                      prefs.getInt(Constant.SHARED_PREFERENCE_LANGUAGE),
                      dataJson),
                  prefs: prefs,
                  icon: icon,
                  coin: devolverTipoMoneda(
                      prefs.getString(Constant.SHARED_PREFERENCE_COIN)),
                  initialPosition: 0,
                  listFood: listFood,
                ),
              );
            }),
            (route) => false,
          );
        }
      } finally {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: ErrorView(
                language: language,
              ),
            );
          }),
          (route) => false,
        );
      }
    });
  }

  Language selectLanguage(int? position, List dataJson) {
    if (position == null) {
      return Language(dataJson: dataJson, positionLanguage: 0);
    } else {
      if (position >= 0 && position <= 1) {
        return Language(dataJson: dataJson, positionLanguage: position);
      } else {
        return Language(dataJson: dataJson, positionLanguage: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(children: [
        Background(asset: "assets/images/screen.webp"),
        Center(
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
          child: CircularProgressIndicator(
            color: Colors.orange,
            strokeAlign: 5,
            strokeWidth: 7,
          ),
        )
      ]),
    );
  }
}
