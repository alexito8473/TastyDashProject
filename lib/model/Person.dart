class Person {
  final String nombre;
  final String gmail;
  final String pasword;
  final List<dynamic> listaComida;
  const Person( {required this.nombre,required this.pasword, required this.gmail,required this.listaComida});

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