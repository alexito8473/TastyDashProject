import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfgsaladillo/home.dart';
import 'package:tfgsaladillo/login.dart';
import 'package:tfgsaladillo/register.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
options:const FirebaseOptions(
    apiKey: "AIzaSyDAoR85r-jMI2Hq9FPQ-12h8SWG3JhVFic",
    appId: "1:1054778682067:android:6e37cde3de5ad269c94226",
    messagingSenderId: "1054778682067",
    projectId: "tfgalejandro-fda96"
),
  );
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


