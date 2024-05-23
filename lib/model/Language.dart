class Language {
  final List<dynamic> datosJson;
  int positionIdioma;

  Language({required this.datosJson, required this.positionIdioma});

  List<dynamic> getDatosJson() {
    return datosJson;
  }

  int getPositionIdioma() {
    return positionIdioma;
  }
}
