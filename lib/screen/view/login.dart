import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
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
import '../../utils/Constant.dart';
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
    BitmapDescriptor icon;
    Person? person;
    String email = _emailController.text;
    String password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      if (email.isEmpty && password.isEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_1"],
            20);
      } else if (email.isNotEmpty && password.isEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_2"],
            25);
      } else if (email.isEmpty && password.isNotEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_3"],
            25);
      }
      return;
    }
    if (!EmailValidator.validate(email)) {
      messageToConsumer(
          widget.language.dataJson[widget.language.positionLanguage]
              ["WARNING_LOGIN_REGISTER_TEXT_4"],
          25);
      return;
    }
    setState(() {
      load = true;
    });
    person = await RealTimeService.checkAndGetUserData(
        email, password, widget.prefs);
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
                  coin: Coin.returnTypeCoin(
                      widget.prefs.getString(Constant.SHARED_PREFERENCE_COIN)),
                  initialPosition: 3,
                  listFood: widget.listFood,
                )),
        (route) => false,
      );
    } else {
      messageToConsumer(
          widget.language.dataJson[widget.language.positionLanguage]
          ["WARNING_LOGIN_REGISTER_TEXT_5"],
          25);
      setState(() {
        load = false;
      });
    }
  }

  void messageToConsumer(String message, double fontSize) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        closeIconColor: Colors.transparent,
        showCloseIcon: false,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: widget.language.dataJson[widget.language.positionLanguage]
              ["WARNING"],
          messageFontSize: fontSize,
          message: message,
          contentType: ContentType.warning,
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        const Background(asset: "assets/images/start.webp"),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ButtonBack(),
                  Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.05, bottom: size.height * 0.05),
                      child: const Titular(title: "Tasty Dash")),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: TextFieldMio(
                        controller: _passwordController,
                        sizeContext: size,
                        hint: widget.language
                                .dataJson[widget.language.positionLanguage]
                            ["Contraseña"],
                        icon: Icons.lock,
                        textType: TextInputType.name,
                        action: TextInputAction.none,
                        obscureText: true,
                      )),
                  Center(
                    child: Container(
                      width: size.width * 0.55,
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.2,
                          vertical: size.height * 0.015),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
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
                                widget.language.dataJson[widget.language
                                    .positionLanguage]["Iniciar_sesion"],
                                style: const TextStyle(fontSize: 20),
                              ),
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
                            vertical: size.width * 0.02),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: 2)),
                        ),
                        child: Text(
                          widget.language
                                  .dataJson[widget.language.positionLanguage]
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
            )))
      ],
    );
  }
}
