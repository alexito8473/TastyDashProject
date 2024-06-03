import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/Language.dart';
import '../../models/Person.dart';
import '../widget/genericWidget.dart';

class AddReview extends StatefulWidget {
  final Person person;
  final String heroTag;
  final Language language;
  final Function addReview;
  const AddReview(
      {super.key,
      required this.person,
      required this.heroTag,
      required this.language,
      required this.addReview});
  @override
  State<StatefulWidget> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController _controller = TextEditingController();
  double assessment = 0;
  void checkReview() async {
    String opinion = _controller.text;
    if (opinion.isEmpty) {
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
      if (opinion.length >= 20 && opinion.length <= 80) {
        await widget.addReview(assessment, opinion);
        Navigator.pop(context);
      } else {
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
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Background(
          asset: "assets/images/backgroundAddReview.webp",
          colorIsFiltered: Colors.black87,
        ),
        Scaffold(
          appBar: AppBar(
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
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Hero(
                          tag: widget.heroTag,
                          child: CachedNetworkImage(
                            colorBlendMode: BlendMode.darken,
                            color: Colors.black26,
                            imageUrl: widget.heroTag,
                            height: size.height * 0.2,
                            width: size.height * 0.2,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
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
                    initialRating: assessment,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    allowHalfRating: true,
                    itemSize: size.width * 0.14,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(Icons.star_half, color: Colors.orange),
                      empty: const Icon(Icons.star, color: Colors.grey),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        assessment = rating;
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
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.03),
                      alignment: Alignment.center,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 10,
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintText: "Yo creo que....",
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.none,
                      )),
                  GestureDetector(
                    onTap: () => checkReview(),
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.5,
                      height: size.height * 0.06,
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.2,
                          vertical: size.height * 0.015),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        widget.language
                                .dataJson[widget.language.positionLanguage]
                            ["TEXT_BUTTON_ADD_REVIEW"],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              )),
            ),
          ),
        )
      ],
    );
  }
}
