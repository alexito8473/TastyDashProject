enum Coin implements Comparable<Coin> {
  LIBRA(symbol: "£", converter: 0.863271),
  EURO(symbol: "€", converter: 1);

  const Coin({required this.symbol, required this.converter});

  final String symbol;
  final double converter;

  static Coin returnTypeCoin(String? symbol) {
    switch (symbol) {
      case "£":
        return Coin.LIBRA;
      case "€":
        return Coin.EURO;
      default:
        return Coin.EURO;
    }
  }

  @override
  int compareTo(Coin other) => symbol.compareTo(other.symbol);
}


