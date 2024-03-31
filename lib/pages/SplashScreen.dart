import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var d = const Duration(seconds: 2);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InicioSesion()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Background(asset: "assets/images/mio.png"),
        const Align(
            alignment: AlignmentDirectional.bottomCenter,
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
                        fontSize: 27,
                        color: Colors.white),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    "by Alejandro Aguilar",
                    style: TextStyle(fontSize: 10, color: Colors.white),
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
            children:  [
              Text("Cargando",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 6,
              )
            ],
          ),
        ))
      ]),
    );
  }
}
