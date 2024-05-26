import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/Person.dart';
import '../widget/genericWidget.dart';

class AddReview extends StatefulWidget {
  final Person person;
  final String heroTag;
  const AddReview({super.key, required this.person, required this.heroTag});
  @override
  State<StatefulWidget> createState() => _AddReview();
}

class _AddReview extends State<AddReview> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                width: size.width,
                child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        stops: [0.4, 0.9],
                        colors: [Colors.transparent, Colors.black])
                        .createShader(bounds),
                    blendMode: BlendMode.darken,
                    child: Container(
                        width: size.width,
                        alignment: Alignment.topRight,
                        height: size.height * 0.34,
                        child: Hero(
                          tag: widget.heroTag,
                          child: CachedNetworkImage(
                            imageUrl: widget.heroTag,
                            height: size.height * 0.654,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )))),

            Container(
              width: size.width,
              height: size.height,
              margin: EdgeInsets.only(top: size.height * 0.3),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/fondoSuelo.webp"),
                      fit: BoxFit.cover,
                      colorFilter:
                      ColorFilter.mode(Colors.black26, BlendMode.darken))),
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: size.width * 0.65,
                                margin: EdgeInsets.only(
                                    bottom: size.height * 0.03,
                                    left: size.width * 0.03,
                                    top: size.height * 0.03),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  "widget.food.nombre",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                )),
                            if (widget.person != null)
                              Container(
                                margin: EdgeInsets.only(right: size.width * 0.05),
                                width: size.width * 0.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),

      floatingActionButton: const ButtonBack(),
    );
  }
}
