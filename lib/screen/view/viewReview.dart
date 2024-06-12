import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tfgsaladillo/models/Food.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';
import 'package:tfgsaladillo/models/Review.dart';

import 'package:tfgsaladillo/services/RealTimeServices.dart';
import 'package:tfgsaladillo/screen/widget/viewReviewWidget.dart';
import 'addReview.dart';

class PageReview extends StatefulWidget {
  final Food food;
  final Person person;
  final Function function;
  final Language language;
  const PageReview(
      {super.key,
      required this.food,
      required this.person,
      required this.function,
      required this.language});

  @override
  State<PageReview> createState() => _PageReviewState();
}

class _PageReviewState extends State<PageReview> {
  List<Review> _listReviewSorted= [];
  int _countMaxReview = 0;
  int _countReviewFiveStar = 0;
  int _countReviewFourStar = 0;
  int _countReviewThreeStar = 0;
  int _countReviewTwoStar = 0;
  int _countReviewOneStar = 0;
  int _countReviewZeroStar = 0;
  @override
  void initState() {
    _recountRating(widget.food.listReview);
    _listReviewSorted.addAll(widget.food.listReview);
    _listReviewSorted.sort((a, b) => b.publication.compareTo(a.publication));
    super.initState();
  }

  void _recountRating(List<dynamic> listReview) {
    _countMaxReview = 0;
    if (_countMaxReview <
        (_countReviewFiveStar =
            listReview.where((element) => element.rating == 5).length)) {
      _countMaxReview = _countReviewFiveStar;
    }
    if (_countMaxReview <
        (_countReviewFourStar = listReview
            .where((element) => element.rating < 5 && element.rating >= 4)
            .length)) {
      _countMaxReview = _countReviewFourStar;
    }
    if (_countMaxReview <
        (_countReviewThreeStar = listReview
            .where((element) => element.rating < 4 && element.rating >= 3)
            .length)) {
      _countMaxReview = _countReviewThreeStar;
    }
    if (_countMaxReview <
        (_countReviewTwoStar = listReview
            .where((element) => element.rating < 3 && element.rating >= 2)
            .length)) {
      _countMaxReview = _countReviewTwoStar;
    }
    if (_countMaxReview <
        (_countReviewOneStar = listReview
            .where((element) => element.rating < 2 && element.rating >= 1)
            .length)) {
      _countMaxReview = _countReviewOneStar;
    }
    if (_countMaxReview <
        (_countReviewZeroStar = listReview
            .where((element) => element.rating < 1 && element.rating >= 0)
            .length)) {
      _countMaxReview = _countReviewZeroStar;
    }
  }

  void _addReview(double rating, String content) async {
    Review nowReview = Review(
        author: widget.person.name,
        publication: DateTime.now(),
        rating: rating,
        content: content);
    setState(() {
      widget.food.listReview.add(nowReview);
      widget.food.assessment += rating;
      widget.food.amountAssessment += 1;
      _recountRating(widget.food.listReview);
      _listReviewSorted.insert(0,nowReview);
    });
    await RealTimeService.addReview(widget.food, nowReview);
    widget.function();
  }

 // Navigate with animation to AddReview
  void _navigateAddReview() {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: AddReview(
            person: widget.person,
            heroTag: widget.food.pathImage,
            language: widget.language,
            addReview: _addReview,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    double totalAssessment =
        widget.food.assessment / widget.food.amountAssessment;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.language.dataJson[widget.language.positionLanguage]
                ["REVIEW"],
            style: const TextStyle(fontSize: 35),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: size.width * 0.01),
                child: IconButton(
                  onPressed: () => _navigateAddReview(),
                  icon: const Icon(Icons.add),
                  color: Colors.black,
                  iconSize: 30,
                ))
          ],
          backgroundColor: Colors.orange,
        ),
        body: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(top: size.height * 0.01),
            width: size.width * 0.9,
            child: Row(
              children: [
                SizedBox(
                    width: size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          (totalAssessment.isNaN ? 0.0 : totalAssessment)
                              .toStringAsFixed(2),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 50),
                        ),
                        RatingBar(
                          initialRating:
                              totalAssessment.isNaN ? 0.0 : totalAssessment,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          allowHalfRating: true,
                          itemSize: size.width * 0.07,
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.orange),
                            half: const Icon(Icons.star_half,
                                color: Colors.orange),
                            empty: const Icon(Icons.star_border_outlined,
                                color: Colors.orange),
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        AutoSizeText(
                          "${widget.food.listReview.length} ${widget.language.dataJson[widget.language.positionLanguage]
                          ["REVIEW"]}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                      ],
                    )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProgressRating(
                      size: size,
                      numberRating: 5,
                      valueRating: _countReviewFiveStar / _countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 4,
                      valueRating: _countReviewFourStar / _countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 3,
                      valueRating: _countReviewThreeStar / _countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 2,
                      valueRating: _countReviewTwoStar / _countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 1,
                      valueRating: _countReviewOneStar / _countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 0,
                      valueRating: _countReviewZeroStar / _countMaxReview,
                    )
                  ],
                ))
              ],
            ),
          ),
          Expanded(
          child:
          Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: ListView.separated(
                reverse: false,
                  separatorBuilder: (context, index) {
                    return Container(
                      height: size.height * 0.002,
                      color: Colors.grey,
                    );
                  },
                  itemCount: _listReviewSorted.length,
                  itemBuilder: (context, index) {
                    return ReviewUser(
                      size: size,
                      review: _listReviewSorted[index],
                    );
                  })))
        ]));
  }
}
