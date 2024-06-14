// Class representing a message with text and the name of the person who sent it
class Message {
  // Constructor to initialize the properties of the Message class
  const Message({required this.text, required this.person});

  // Final property to store the text of the message
  final String text;

  // Final property to store the name of the person who sent the message
  final String person;
}
