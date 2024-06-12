import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/screen/view/splashScreen.dart';

class ErrorView extends StatefulWidget {
  final Language? language;
  const ErrorView({super.key, required this.language});

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  late String title;
  late String subtitle;
  late String titleButton;
  void _navigationToSplashScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: const SplashScreen(),
        );
      }),
      (route) => false,
    );
  }

  @override
  void initState() {
    if (widget.language == null) {
      title = "Something went wrong!";
      subtitle =
          "Something has not worked correctly, make sure you have the latest version or are connected to the internet.";
      titleButton = "Try again";
    } else {
      title = widget.language!.dataJson[widget.language!.positionLanguage]
          ["ERROR_VIEW_TITLE"];
      subtitle = widget.language!.dataJson[widget.language!.positionLanguage]
          ["ERROR_VIEW_SUBTITLE"];
      titleButton = widget.language!.dataJson[widget.language!.positionLanguage]
          ["ERROR_VIEW_BUTTON"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: [
              Lottie.asset('assets/json/gear.json',
                  reverse: true, frameRate: const FrameRate(60)),
              AutoSizeText(
                title,
                maxLines: 1,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              AutoSizeText(
                subtitle,
                maxLines: 3,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        )),
        bottomNavigationBar: GestureDetector(
          onTap: () => _navigationToSplashScreen(),
          child: Container(
            width: size.width,
            color: Colors.orange,
            alignment: Alignment.center,
            height: size.height * 0.1,
            child: Text(
              titleButton,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
