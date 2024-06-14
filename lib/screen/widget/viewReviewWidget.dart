import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../../models/Review.dart';

class ReviewUser extends StatelessWidget {
  final Size size;
  final Review review;
  const ReviewUser({super.key, required this.size, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.19,
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
                allowHalfRating: true,
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
            style: const TextStyle(color: Colors.black, fontSize: 21),
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