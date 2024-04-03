import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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