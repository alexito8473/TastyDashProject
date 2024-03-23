import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Registrarse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Stack(
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: EdgeInsets.symmetric(
                vertical:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 200
                    : 30),
            children: [
              Titular(),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? size.height * 0.06
                            : size.height * 0.11,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(30)),
                        child: const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.black,
                                )),
                            border: InputBorder.none,
                            hintText: "Nombre",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? size.height * 0.06
                            : size.height * 0.11,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(30)),
                        child: const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.email,
                                  size: 30,
                                  color: Colors.black,
                                )),
                            border: InputBorder.none,
                            hintText: "Gmail",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? size.height * 0.06
                            : size.height * 0.11,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(30)),
                        child: const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.lock,
                                  size: 30,
                                  color: Colors.black,
                                )),
                            border: InputBorder.none,
                            hintText: "Contraseña",
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 60,
                      width: 240,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: FloatingActionButton(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                        onPressed: () {
                          print("Funciona");
                        },
                        child: Text(
                          "Registrarse",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.keyboard_backspace)
          ),
        )
      ],
    );
  }
}

class Titular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Flexible(
        child: Center(
          child: Text("Registrarse",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40)),
        ));
  }
}
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.centerRight,
            colors: [Colors.black87, Colors.transparent]).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/register.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black38, BlendMode.darken)))));
  }
}