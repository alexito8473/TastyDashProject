import 'dart:convert';

import 'package:flutter/services.dart';

Future<List> readJson() async {
  return jsonDecode(await rootBundle.loadString("assets/json/leng.json"));
}