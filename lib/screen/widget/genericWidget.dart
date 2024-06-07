import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PositionButtonBack extends StatelessWidget {
  const PositionButtonBack({
    super.key,
    required this.size,
  });
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: size.height * 0.01,
        left: size.width * 0.04,
        child: SafeArea(
            child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: size.height * 0.07,
            height: size.height * 0.07,
            child: Icon(
              Icons.arrow_back,
              color: Colors.orange,
              size: size.height * 0.05,
            ),
          ),
        )));
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: size.width * 0.14,
          width: size.width * 0.14,
          margin: EdgeInsets.only(
              left: size.width * 0.05, top: size.height * 0.02),
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
        ));
  }
}

class Background extends StatelessWidget {
  final String asset;
  final Alignment begin;
  final Alignment end;
  final Color colorIsFiltered;
  const Background(
      {super.key,
      required this.asset,
      this.begin = Alignment.bottomRight,
      this.end = Alignment.centerRight,
      this.colorIsFiltered = Colors.black38});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
                begin: begin,
                end: Alignment.centerRight,
                colors: const [Colors.black87, Colors.transparent])
            .createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(colorIsFiltered, BlendMode.darken)))));
  }
}

class TextFieldMio extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Size sizeContext;
  final IconData icon;
  final TextInputType textType;
  final TextInputAction action;
  final bool obscureText;

  const TextFieldMio(
      {super.key,
      required this.hint,
      required this.controller,
      required this.sizeContext,
      required this.icon,
      required this.textType,
      required this.action,
      required this.obscureText});

  @override
  State<StatefulWidget> createState() => _TextFieldMio();
}

class _TextFieldMio extends State<TextFieldMio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.sizeContext.height * 0.01),
      child: Container(
        alignment: Alignment.center,
        height: widget.sizeContext.height * 0.06,
        width: widget.sizeContext.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white60, borderRadius: BorderRadius.circular(24)),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  widget.icon,
                  size: 30,
                  color: Colors.black,
                )),
            border: InputBorder.none,
            hintStyle: const TextStyle(fontWeight: FontWeight.bold),
            hintText: widget.hint,
          ),
          obscureText: widget.obscureText,
          keyboardType: widget.textType,
          textInputAction: widget.action,
        ),
      ),
    );
  }
}

class Titular extends StatelessWidget {
  final String title;

  const Titular({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40)));
  }
}

void messageToCustomer(BuildContext context, String mensage, double font) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 1,
    width: 300.0,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.white70,
    duration: const Duration(milliseconds: 1100),
    content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Text(
          mensage,
          style: TextStyle(
              fontSize: font, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        )),
  ));
}
