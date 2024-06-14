// Class representing a Language with JSON data and a position indicator
class Language {
  // Final property to store JSON data related to the language
  final List<dynamic> dataJson;

  // Property to store the position or index of the language
  int positionLanguage;

  // Constructor to initialize the properties of the Language class
  Language({required this.dataJson, required this.positionLanguage});
}
