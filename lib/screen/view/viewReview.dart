import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:tfgsaladillo/services/RealTimeServices.dart';

import '../../models/Food.dart';
import '../../models/Language.dart';
import '../../models/Person.dart';
import '../../models/Review.dart';
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
  State<StatefulWidget> createState() => _PageReview();
}

class _PageReview extends State<PageReview> {
  int countMaxReview = 0;
  int countReviewFiveStar = 0;
  int countReviewFourStar = 0;
  int countReviewThreeStar = 0;
  int countReviewTwoStar = 0;
  int countReviewOneStar = 0;
  int countReviewZeroStar = 0;
  @override
  void initState() {
    recountRating(widget.food.listReview);
    super.initState();
  }

  void recountRating(List<dynamic> listReview) {
    countMaxReview = 0;
    if (countMaxReview <
        (countReviewFiveStar =
            listReview.where((element) => element.rating == 5).length)) {
      countMaxReview = countReviewFiveStar;
    }
    if (countMaxReview <
        (countReviewFourStar = listReview
            .where((element) => element.rating < 5 && element.rating >= 4)
            .length)) {
      countMaxReview = countReviewFourStar;
    }
    if (countMaxReview <
        (countReviewThreeStar = listReview
            .where((element) => element.rating < 4 && element.rating >= 3)
            .length)) {
      countMaxReview = countReviewThreeStar;
    }
    if (countMaxReview <
        (countReviewTwoStar = listReview
            .where((element) => element.rating < 3 && element.rating >= 2)
            .length)) {
      countMaxReview = countReviewTwoStar;
    }
    if (countMaxReview <
        (countReviewOneStar = listReview
            .where((element) => element.rating < 2 && element.rating >= 1)
            .length)) {
      countMaxReview = countReviewOneStar;
    }
    if (countMaxReview <
        (countReviewZeroStar = listReview
            .where((element) => element.rating < 1 && element.rating >= 0)
            .length)) {
      countMaxReview = countReviewZeroStar;
    }
  }

  void addReview(double rating, String content) async {
    Review nowReview = Review(
        author: widget.person.name,
        publication: DateTime.now(),
        rating: rating,
        content: content);
    setState(() {
      widget.food.listReview.add(nowReview);
      widget.food.assessment += rating;
      widget.food.amountAssessment += 1;
      recountRating(widget.food.listReview);
    });
    await RealTimeService.addReview(widget.food, nowReview);
    widget.function();
  }

  void navigateAddReview() {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: AddReview(
            person: widget.person,
            heroTag: widget.food.pathImage,
            language: widget.language,
            addReview: addReview,
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
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          surfaceTintColor: Colors.grey.shade200,
          centerTitle: true,
          title: const Text(
            "Reviews",
            style: TextStyle(fontSize: 35),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: size.width * 0.01),
                child: IconButton(
                  onPressed: () => navigateAddReview(),
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
              borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.only(top: size.height * 0.01),
            width: size.width * 0.9,
            height: size.height * 0.2,
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
                            empty: const Icon(Icons.star_border_outlined, color: Colors.orange),
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        AutoSizeText(
                          "${widget.food.listReview.length} review",
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
                      valueRating: countReviewFiveStar / countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 4,
                      valueRating: countReviewFourStar / countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 3,
                      valueRating: countReviewThreeStar / countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 2,
                      valueRating: countReviewTwoStar / countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 1,
                      valueRating: countReviewOneStar / countMaxReview,
                    ),
                    ProgressRating(
                      size: size,
                      numberRating: 0,
                      valueRating: countReviewZeroStar / countMaxReview,
                    )
                  ],
                ))
              ],
            ),
          ),
          Container(
              width: size.width,
              height: size.height * 0.6,
              padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(
                      height: size.height * 0.002,
                      color: Colors.grey,
                    );
                  },
                  itemCount: widget.food.listReview.length,
                  itemBuilder: (context, index) {
                    return ReviewUser(
                      size: size,
                      review: widget.food.listReview[index],
                    );
                  }))
        ]));
  }
}

class ReviewUser extends StatelessWidget {
  final Size size;
  final Review review;
  const ReviewUser({super.key, required this.size, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.18,
      padding: EdgeInsets.symmetric(
        vertical: size.width * 0.03,
        horizontal: size.width * 0.03,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.author,
            style: const TextStyle(color: Colors.black, fontSize: 25),
            maxLines: 1,
          ),
          Row(
            children: [
              RatingBar(
                initialRating: review.rating,
                direction: Axis.horizontal,
                itemCount: 5,
                ignoreGestures: true,
                itemSize: size.width * 0.06,
                ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color: Colors.orange),
                  half: const Icon(Icons.star_half, color: Colors.orange),
                  empty: const Icon(Icons.star_border_outlined, color: Colors.orange),
                ),
                onRatingUpdate: (rating) {},
              ),
              Text(
                DateFormat("   dd MMM yyyy")
                    .format(review.publication)
                    .toString(),
                style: const TextStyle(fontSize: 18, color: Colors.black),
              )
            ],
          ),
          AutoSizeText(
            maxLines: 2,
            review.content,
            style: const TextStyle(color: Colors.black, fontSize: 26),
          )
        ],
      ),
    );
  }
}

class ProgressRating extends StatelessWidget {
  final double valueRating;
  final int numberRating;
  final Size size;
  const ProgressRating(
      {super.key,
      required this.size,
      required this.valueRating,
      required this.numberRating});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Row(
          children: [
            SizedBox(
                width: size.width * 0.11,
                child: Row(
                  children: [
                    AutoSizeText(
                      numberRating.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: size.width * 0.06,
                    )
                  ],
                )),
            Expanded(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.shade100,
              color: Colors.orange,
              value: valueRating.isNaN
                  ? 0.0
                  : valueRating.isInfinite
                      ? 0.0
                      : valueRating,
            ))
          ],
        ));
  }
}
