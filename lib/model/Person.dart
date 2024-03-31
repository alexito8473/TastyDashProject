class Person {
  final String nombre;
  final String gmail;
  final String pasword;
  const Person( {required this.nombre,required this.pasword, required this.gmail});

  String getNombre(){
    return nombre;
  }
  String getGmail(){
    return gmail;
  }
  String getPasword(){
    return pasword;
  }
}