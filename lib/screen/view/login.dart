import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/view/home.dart';
import 'package:tfgsaladillo/screen/view/register.dart';

import '../../models/Food.dart';
import '../../services/RealTimeServices.dart';
import '../widget/genericWidget.dart';

class Login extends StatefulWidget {
  final Language language;
  final SharedPreferences prefs;
  final List<Food> listFood;

  const Login(
      {super.key,
      required this.language,
      required this.prefs,
      required this.listFood});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool load = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Person person;
  void navigationRegister() {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1100),
      reverseTransitionDuration: const Duration(milliseconds: 700),
      barrierColor: Colors.black,
      opaque: true,
      barrierDismissible: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: Register(
            language: widget.language,
            prefs: widget.prefs,
            listFood: widget.listFood,
          ),
        );
      },
    ));
  }

  void login() async {
    setState(() {
      load = true;
    });
    BitmapDescriptor icon;
    Person? person = await RealTimeService.checkAndGetUserData(
        _emailController.text, _passwordController.text, widget.prefs);
    if (person != null) {
      icon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), "assets/images/ic_map.webp");
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  person: person,
                  language: widget.language,
                  prefs: widget.prefs,
                  icon: icon,
                  coin: devolverTipoMoneda(
                      widget.prefs.getString("SimboloMoneda")),
                  initialPosition: 3,
                  listFood: widget.listFood,
                )),
        (route) => false,
      );
    } else {
      messageToCustomer(context, "Gmail y/o contraseña no son correctos", 15);
      setState(() {
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Background(asset: "assets/images/start.webp"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.1, bottom: size.height * 0.05),
                  child: const Titular(title: "Tasty Dash")),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: TextFieldMio(
                    controller: _emailController,
                    sizeContext: size,
                    hint: "Email",
                    icon: Icons.email,
                    textType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    obscureText: false,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: TextFieldMio(
                    controller: _passwordController,
                    sizeContext: size,
                    hint: widget.language.dataJson[widget.language.positionLanguage]
                        ["Contraseña"],
                    icon: Icons.lock,
                    textType: TextInputType.name,
                    action: TextInputAction.none,
                    obscureText: true,
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.2,
                    vertical: size.height * 0.015),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: FloatingActionButton(
                  heroTag: "moverFloating",
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  onPressed: () => login(),
                  child: load
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text(
                          widget.language.dataJson[widget.language.positionLanguage]
                              ["Iniciar_sesion"],
                          style: const TextStyle(fontSize: 20),
                        ),
                ),
              ),
              GestureDetector(
                onTap: () => navigationRegister(),
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.28,
                        vertical: size.width * 0.01),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 2)),
                    ),
                    child: Text(
                      widget.language.dataJson[widget.language.positionLanguage]
                          ["Crear_una_cuenta"],
                      style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          height: BorderSide.strokeAlignOutside,
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    )),
              )
            ],
          ),
          floatingActionButton: const ButtonBack(),
        )
      ],
    );
  }
}
