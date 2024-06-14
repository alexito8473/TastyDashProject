// Class representing a person with a name, email, and a list of favorite foods
class Person {
  // Final property to store the name of the person
  final String name;

  // Final property to store the Gmail address of the person
  final String gmail;

  // Property to store a list of favorite foods, initially an empty list
  List? listFood = [];

  // Constructor to initialize the properties of the Person class
  Person({required this.name, required this.gmail, required this.listFood});
}
