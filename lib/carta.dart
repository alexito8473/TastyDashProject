import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Carta extends StatefulWidget {
  const Carta({super.key});
  @override
  State<StatefulWidget> createState() =>_Carta();
}
class _Carta extends State<Carta>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Carta",style: TextStyle(color: Colors.black)),
      ),
    );
  }
}