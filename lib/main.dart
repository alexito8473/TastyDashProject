import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfgsaladillo/screen/view/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDAoR85r-jMI2Hq9FPQ-12h8SWG3JhVFic",
        appId: "1:1054778682067:android:6e37cde3de5ad269c94226",
        messagingSenderId: "1054778682067",
        projectId: "tfgalejandro-fda96",
        databaseURL:
            "https://tfgalejandro-fda96-default-rtdb.europe-west1.firebasedatabase.app"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.abelTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
      },
    );
  }
}
