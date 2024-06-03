import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/Coin.dart';
import '../../models/Food.dart';
import '../../models/Language.dart';
import '../../models/Person.dart';
import '../view/pageFood.dart';

class ShowList extends StatefulWidget {
  final Size size;
  final List<Food> listFood;
  final Coin coin;
  final Language language;
  final Person person;
  final Function addOrRemoveList;
  final Function updateState;

  const ShowList(
      {super.key,
      required this.size,
      required this.listFood,
      required this.coin,
      required this.language,
      required this.person,
      required this.addOrRemoveList,
      required this.updateState});

  @override
  State<StatefulWidget> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      margin: EdgeInsets.only(
          top: widget.size.height * 0.01, bottom: widget.size.height * 0.01),
      child: GridView.builder(
        itemCount: widget.listFood.length,
        itemBuilder: (context, index) {
          return BannerFoodGrid(
            food: widget.listFood[index],
            coin: widget.coin,
            language: widget.language,
            person: widget.person,
            addOrRemoveList: widget.addOrRemoveList,
            listFood: widget.listFood,
            updateState: widget.updateState,
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
    );
  }
}

class BannerFoodGrid extends StatefulWidget {
  final Food food;
  final Coin coin;
  final Language language;
  final Person person;
  final List<Food> listFood;
  final Function addOrRemoveList;
  final Function updateState;

  const BannerFoodGrid(
      {super.key,
      required this.food,
      required this.coin,
      required this.language,
      required this.person,
      required this.addOrRemoveList,
      required this.listFood,
      required this.updateState});

  @override
  State<StatefulWidget> createState() => _BannerFoodGridState();
}

class _BannerFoodGridState extends State<BannerFoodGrid> {
  @override
  Widget build(BuildContext context) {
    double resultAssessment =
        widget.food.assessment / widget.food.amountAssessment;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          barrierColor: Colors.black54,
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
                opacity: animation,
                child: PageFood(
                  food: widget.food,
                  language: widget.language,
                  coin: widget.coin,
                  person: widget.person,
                  function: widget.addOrRemoveList,
                ));
          },
        ));
        widget.updateState();
      },
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          height: size.height * 0.15,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(
                      25.0), // Ajusta el radio de los bordes
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    color: Colors.black54,
                    colorBlendMode: BlendMode.darken,
                    imageUrl: widget.food.pathImage,
                  )),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    maxLines: 1,
                    widget.food.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  RatingBar(
                    initialRating: resultAssessment,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemSize: size.width * 0.07,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(Icons.star_half, color: Colors.orange),
                      empty: const Icon(Icons.star_outline, color: Colors.grey),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  AutoSizeText(
                    maxLines: 1,
                    "${widget.food.timeMinute} ${widget.language.dataJson[widget.language.positionLanguage]["Minuto"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
