import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfgsaladillo/home.dart';
import 'package:tfgsaladillo/login.dart';
import 'package:tfgsaladillo/register.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
        initialRoute: '/',
        routes: {
        '/':(context)=>InicioSesion(),
          '/register':(context)=>Registrarse(),
          '/HomePage':(context)=>HomePage(),
        },
    );
  }
}


