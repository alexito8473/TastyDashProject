import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Person.dart';

class SettingView extends StatefulWidget {
  final Person person;
  final Idioma idioma;
  final SharedPreferences prefs;

  const SettingView({super.key, required this.person, required this.idioma, required this.prefs});
  @override
  State<StatefulWidget> createState() =>_SettingView();
}
class _SettingView extends State<SettingView>{
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}