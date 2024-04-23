enum Moneda implements Comparable<Moneda> {
  LIBRA(simbolo: "£", conversor: 0.863271),
  EURO(simbolo: "€", conversor: 1);
   const Moneda({required this.simbolo,required this.conversor});
   final String simbolo;
   final double conversor;


  @override
  int compareTo(Moneda other) =>simbolo.compareTo(other.simbolo);
}

Moneda devolverTipoMoneda(String? simbolo){
  switch(simbolo){
    case "£":return Moneda.LIBRA;
    case "€":return Moneda.EURO;
    case null:return Moneda.EURO;
    default:return Moneda.EURO;
  }
}
