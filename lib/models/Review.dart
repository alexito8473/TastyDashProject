// Class representing a review with an author, publication date, rating, and content
class Review {
  // Property to store the author of the review
  String author;

  // Property to store the publication date of the review
  DateTime publication;

  // Property to store the rating given in the review
  double rating;

  // Property to store the content of the review
  String content;

  // Constructor to initialize the properties of the Review class
  Review({
    required this.author,
    required this.publication,
    required this.rating,
    required this.content
  });
}
