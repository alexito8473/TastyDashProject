import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Person extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_Person();
}
class _Person extends State<Person>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Text("Persona"),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pop(context);
          },
          backgroundColor: Colors.red,
          child: Icon(FontAwesomeIcons.powerOff),
        ),
      ),
    );
  }
}