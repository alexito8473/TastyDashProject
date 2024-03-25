import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/services/AuthServices.dart';
import 'package:firebase_core/firebase_core.dart';

class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});
  @override
  State<InicioSesion> createState() => _InicioSesion();
}

class _InicioSesion extends State<InicioSesion> {
  TextEditingController _gmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthService authService= AuthService();
  @override
  void dispose() {
    _gmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    String gmail = _gmailController.text;
    String password = _passwordController.text;
    bool user = await authService.sigIn(gmail, password);
    if(user){
      Navigator.pushNamed(context, "/HomePage");
    }else{
      ScaffoldMessenger.of(context).showSnackBar( const
      SnackBar(
        elevation: 1,
        content: Text("Mostrar mensaje",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white70,
      )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        child: TextField(
                          controller: _gmailController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
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
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        // Horizontal =size.height*0.1
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? size.height * 0.06
                            : size.height * 0.11,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          controller: _passwordController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
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
                          login(context);
                        },
                        child: const Text(
                          "Iniciar sesión",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 165,
                      margin: EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: 1))),
                      child: FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        child: const Text(
                          "Crear una cuenta",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              height: BorderSide.strokeAlignOutside,
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
      child: Text("Tasty Dash",
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
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.black, Colors.transparent]).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/start.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)))));
  }
}
