import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
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
import '../widget/genericWidget.dart';

class Register extends StatefulWidget {
  final Language language;
  final SharedPreferences prefs;
  final List<Food> listFood;

  const Register(
      {super.key,
      required this.language,
      required this.prefs,
      required this.listFood});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool load = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Person person;

  int value = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register() async {
    BitmapDescriptor icon;
    Person? person;
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      if (email.isEmpty && password.isEmpty && name.isEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_7"],
            18);
      } else if (email.isNotEmpty && password.isEmpty && name.isEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_8"],
            18);
      } else if (email.isEmpty && password.isNotEmpty && name.isEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_9"],
            18);
      } else if (email.isEmpty && password.isEmpty && name.isNotEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_1"],
            18);
      } else if (email.isNotEmpty && password.isNotEmpty && name.isEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_10"],
            18);
      } else if (email.isNotEmpty && password.isEmpty && name.isNotEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_11"],
            18);
      } else if (email.isEmpty && password.isNotEmpty && name.isNotEmpty) {
        messageToConsumer(
            widget.language.dataJson[widget.language.positionLanguage]
                ["WARNING_LOGIN_REGISTER_TEXT_12"],
            18);
      }
      return;
    }
    if (!EmailValidator.validate(email)) {
      messageToConsumer(
          widget.language.dataJson[widget.language.positionLanguage]
              ["WARNING_LOGIN_REGISTER_TEXT_4"],
          20);
      return;
    }
    setState(() {
      load = true;
    });
    person =
        await RealTimeService.setUserData(name, email, password, widget.prefs);
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
              ["WARNING_LOGIN_REGISTER_TEXT_6"],
          20);
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
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      const Background(asset: "assets/images/register.webp"),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                const ButtonBack(),
                Padding(
                    padding: EdgeInsets.only(top: size.height * 0.045),
                    child: Titular(
                        title: widget.language
                                .dataJson[widget.language.positionLanguage]
                            ["Registrarse"])),
                Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.05,
                        left: size.width * 0.1,
                        right: size.width * 0.1),
                    child: TextFieldMio(
                      hint: widget.language
                          .dataJson[widget.language.positionLanguage]["Nombre"],
                      sizeContext: size,
                      textType: TextInputType.name,
                      icon: Icons.person,
                      controller: _nameController,
                      action: TextInputAction.next,
                      obscureText: false,
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: TextFieldMio(
                      hint: "Email",
                      sizeContext: size,
                      textType: TextInputType.emailAddress,
                      icon: Icons.email,
                      controller: _emailController,
                      action: TextInputAction.next,
                      obscureText: false,
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
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
                            onPressed: () => register(),
                            child: load
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Text(
                                    widget.language.dataJson[widget.language
                                        .positionLanguage]["Registrarse"],
                                    style: const TextStyle(fontSize: 20),
                                  ))))
              ]))))
    ]);
  }
}
