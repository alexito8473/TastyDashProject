class Idioma {
  final List<dynamic> datosJson;
  int positionIdioma;
  Idioma({ required this.datosJson, required this.positionIdioma});

  List<dynamic> getDatosJson(){
    return datosJson;
  }
  int getPositionIdioma(){
    return positionIdioma;
  }
}