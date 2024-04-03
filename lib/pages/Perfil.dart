import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/login.dart';

class Perfil extends StatefulWidget {
  final Idioma idioma;
  final Person person;
  final SharedPreferences prefs;
  const Perfil({super.key, required this.person, required this.idioma, required this.prefs});
  @override
  State<StatefulWidget> createState() =>_Perfil();
}
class _Perfil extends State<Perfil>{
  late final SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    DatabaseReference date= FirebaseDatabase.instance.ref().child('Person/gmail12');
    return Center(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 200),
                child:  Text(widget.person.nombre),
              )

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            prefs = await SharedPreferences.getInstance();
            prefs.remove("Name");
            prefs.remove("Gmail");
            prefs.remove("Password");
            await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> InicioSesion(idioma: widget.idioma, prefs: prefs,)),(route) => false,);
          },
          backgroundColor: Colors.red,
          child: const Icon(FontAwesomeIcons.powerOff),
        ),
      ),
    );
  }
}