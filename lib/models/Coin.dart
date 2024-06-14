// Enum representing different types of coins
enum Coin implements Comparable<Coin> {
  // Definition of enum instances with their properties
  LIBRA(symbol: "£", converter: 0.863271),  // Libra with symbol "£" and conversion rate 0.863271
  EURO(symbol: "€", converter: 1);          // Euro with symbol "€" and conversion rate 1

  // Constructor to initialize the properties of each enum instance
  const Coin({required this.symbol, required this.converter});

  // Final properties of the enum
  final String symbol;     // Symbol of the coin
  final double converter;  // Conversion rate of the coin

  // Static method to return the type of coin based on the provided symbol
  static Coin returnTypeCoin(String? symbol) {
    // Evaluate the symbol and return the corresponding enum instance
    switch (symbol) {
      case "£":
        return Coin.LIBRA;  // Return LIBRA if the symbol is "£"
      case "€":
        return Coin.EURO;   // Return EURO if the symbol is "€"
      default:
        return Coin.EURO;   // Return EURO by default if the symbol doesn't match
    }
  }

  // Implementation of the compareTo method from the Comparable interface
  @override
  int compareTo(Coin other) => symbol.compareTo(other.symbol);  // Compare coins based on their symbols
}



