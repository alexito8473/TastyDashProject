import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Person.dart'; // Importing the Person model
import 'package:tfgsaladillo/screen/widget/genericWidget.dart'; // Importing the Background widget and others

// Stateful widget for adding a review
class AddReview extends StatefulWidget {
  final Person person; // Person for whom the review is being added
  final Language language; // Language used in the screen
  final Function addReview; // Function to add the review

  // Constructor for the widget
  const AddReview({
    Key? key,
    required this.person,
    required this.language,
    required this.addReview,
  }) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState(); // Creates the state associated with the widget
}

// State of the AddReview widget
class _AddReviewState extends State<AddReview> {
  final TextEditingController _controller = TextEditingController(); // Controller for the text field
  double _assessment = 0; // Initial value for the review rating

  // Method to validate and submit the review
  void _checkReview() async {
    String opinion = _controller.text; // Gets the text from the entered opinion

    if (opinion.isEmpty) {
      // If the opinion is empty, shows a warning Snackbar
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          closeIconColor: Colors.transparent,
          showCloseIcon: false,
          elevation: 10,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: widget.language.dataJson[widget.language.positionLanguage]
            ["WARNING"],
            message: widget.language.dataJson[widget.language.positionLanguage]
            ["WARNING_TEXT_1"],
            contentType: ContentType.warning,
          ),
        ));
    } else {
      // If the opinion has valid length
      if (opinion.length >= 20 && opinion.length <= 80) {
        // Calls addReview function to add the review
        await widget.addReview(_assessment, opinion);
        Navigator.pop(context); // Closes the add review screen
      } else {
        // Shows a warning Snackbar if the opinion length is not valid
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            closeIconColor: Colors.transparent,
            showCloseIcon: false,
            elevation: 10,
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: widget.language.dataJson[widget.language.positionLanguage]
              ["WARNING"],
              message: widget.language
                  .dataJson[widget.language.positionLanguage]["WARNING_TEXT_2"],
              contentType: ContentType.warning,
            ),
          ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Gets the size of the screen

    return Stack(
      children: [
        const Background(
          asset: "assets/images/backgroundAddReview.webp",
          colorIsFiltered: Colors.black87,
        ),
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.language.dataJson[widget.language.positionLanguage]["ADD_REVIEW"],
              style: const TextStyle(fontSize: 30),
            ),
            backgroundColor: Colors.orange,
          ),
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
                      alignment: Alignment.center,
                      width: size.width,
                      child: Text(
                        widget.language.dataJson[widget.language.positionLanguage]
                        ["TITLE_ADD_REVIEW"],
                        style: const TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    RatingBar(
                      initialRating: _assessment,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      allowHalfRating: true,
                      itemSize: size.height * 0.05,
                      ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(Icons.star_half, color: Colors.orange),
                        empty: const Icon(Icons.star, color: Colors.grey),
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _assessment = rating;
                        });
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
                      alignment: Alignment.center,
                      width: size.width,
                      child: Text(
                        widget.language.dataJson[widget.language.positionLanguage]
                        ["SUBTITLE_ADD_REVIEW"],
                        style: const TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      alignment: Alignment.center,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 10,
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintText: "I think...",
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.none,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _checkReview(),
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.2,
                            vertical: size.height * 0.015),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.language
                              .dataJson[widget.language.positionLanguage]["TEXT_BUTTON_ADD_REVIEW"],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
