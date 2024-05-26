import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../models/Food.dart';
import '../../models/Person.dart';
import '../../models/Review.dart';
import '../widget/genericWidget.dart';
import 'addReview.dart';

class PageReview extends StatefulWidget {
  final Food food;
  final Person person;
  final Function function;

  const PageReview(
      {super.key,
      required this.food,
      required this.person,
      required this.function});

  @override
  State<StatefulWidget> createState() => _PageReview();
}

class _PageReview extends State<PageReview> {
  void addReview() {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: AddReview(
            person: widget.person,
            heroTag:  widget.food.foto,
          ),
        );
      },
    ));
    /*
    setState(() {
      widget.food.listReview.add(Review(
          autor: widget.person.name,
          publicacion: DateTime.now(),
          valoracion: 5,
          content:
              'Hola madre mia esto es algo madfnasdjfbasdjfasdklfbasjdbasdhmnbcuasdb fasdbfuasdfhasdbfjhsfhbashfbsjfajfbasfjhqwebfuisdbfasdbdfhsehfasdvcyhasbdjkfaseuifshfbvasdhvbasifbuyasefbasdfv'));
      widget.food.valoracion += 5;
      widget.food.numValoracion += 1;
    });
    widget.function();
     */
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Hero(
            tag: widget.food.foto,
            child: CachedNetworkImage(
              colorBlendMode: BlendMode.darken,
              color: Colors.black87,
              imageUrl: widget.food.foto,
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            )),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text(
                "Review",
                style: TextStyle(fontSize: 30),
              ),
              backgroundColor: Colors.orange,
            ),
            body: ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  height: size.height * 0.05,
                );
              },
              itemCount: widget.food.listReview.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(
                        top: index == 0 ? size.height * 0.05 : 0),
                    child: ReviewUser(
                      size: size,
                      review: widget.food.listReview[index],
                    ));
              },
            ),
            bottomNavigationBar: Container(
              width: size.width,
              height: size.height * 0.1,
              margin: EdgeInsets.only(bottom: size.height*0.011),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      addReview();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.orange, Colors.orange.shade800])),
                      margin: EdgeInsets.only(
                          top: size.height * 0.02,
                          bottom: size.height * 0.01,
                          left: size.width * 0.05),
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      child: const Text(
                        "Añadir Review",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.05),
                    child: const ButtonBack(),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class ReviewUser extends StatelessWidget {
  final Size size;
  final Review review;

  const ReviewUser({super.key, required this.size, required this.review});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width,
        height: size.height * 0.2,
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.03, right: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Author: ${review.autor}",
                style: const TextStyle(color: Colors.white, fontSize: 25),
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    DateFormat("HH:mm yyyy/MM/dd")
                        .format(review.publicacion)
                        .toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  RatingBar(
                    initialRating: review.valoracion,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemSize: size.width * 0.07,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(Icons.star, color: Colors.orange),
                      empty: const Icon(Icons.star, color: Colors.grey),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
              Expanded(
                  child: AutoSizeText(
                review.content,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ))
            ],
          ),
        ));
  }
}
