enum Coin implements Comparable<Coin> {
  LIBRA(simbolo: "£", conversor: 0.863271),
  EURO(simbolo: "€", conversor: 1);

  const Coin({required this.simbolo, required this.conversor});

  final String simbolo;
  final double conversor;

  @override
  int compareTo(Coin other) => simbolo.compareTo(other.simbolo);
}

Coin devolverTipoMoneda(String? simbolo) {
  switch (simbolo) {
    case "£":
      return Coin.LIBRA;
    case "€":
      return Coin.EURO;
    default:
      return Coin.EURO;
  }
}
