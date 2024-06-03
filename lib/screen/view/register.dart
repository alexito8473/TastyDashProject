import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/models/Coin.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/screen/view/home.dart';

import '../../models/Food.dart';
import '../../services/RealTimeServices.dart';
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
    Person? person = await RealTimeService.setUserData(_nameController.text,
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
      messageToCustomer(context, "No existe el usuario", 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Background(asset: "assets/images/register.webp"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: size.height * 0.1),
                  child: Titular(
                      title:
                          widget.language.dataJson[widget.language.positionLanguage]
                              ["Registrarse"])),
              Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.05,
                      left: size.width * 0.1,
                      right: size.width * 0.1),
                  child: TextFieldMio(
                    hint: widget.language.dataJson[widget.language.positionLanguage]
                        ["Nombre"],
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
                  onPressed: () => register(),
                  child: Text(
                    widget.language.dataJson[widget.language.positionLanguage]
                        ["Registrarse"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: const ButtonBack(),
        )
      ],
    );
  }
}
