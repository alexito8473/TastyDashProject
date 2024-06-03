import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Language.dart';

import '../view/chatAi.dart';

class PoliticalText extends StatelessWidget {
  final Language language;

  const PoliticalText({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
        width: size.width * .8,
        height: size.height * .7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(language.dataJson[language.positionLanguage]["Politica_Text1"],
                  style: const TextStyle(fontSize: 18)),
              Text(language.dataJson[language.positionLanguage]["Politica_Text2"],
                  style: const TextStyle(fontSize: 18)),
              Text(language.dataJson[language.positionLanguage]["Politica_Text3"],
                  style: const TextStyle(fontSize: 18)),
              Text(language.dataJson[language.positionLanguage]["Politica_Text4"],
                  style: const TextStyle(fontSize: 18)),
              Text(language.dataJson[language.positionLanguage]["Politica_Text5"],
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        ));
  }
}

class ButtonTastyGpt extends StatelessWidget {
  final Size size;
  final Language language;
  const ButtonTastyGpt({super.key, required this.size, required this.language});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            barrierColor: Colors.black54,
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child:  ChatAi(language: language,)
              );
            },
          ));
        },
        child: Container(
            width: size.width * 0.7,
            height: size.height * 0.06,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: size.height * 0.015),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text("TastyGPT",
                style: TextStyle(fontSize: 21, color: Colors.black))));
  }
}

class ButtonTermOfUse extends StatelessWidget {
  final Language language;
  final Size size;

  const ButtonTermOfUse(
      {super.key, required this.language, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              barrierDismissible: false,
              barrierColor: Colors.black.withOpacity(0.6),
              useSafeArea: false,
              context: context,
              builder: (context) => AlertDialog(
                  title: Row(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: size.width * .1,
                        height: size.height * .05,
                        child: const Icon(Icons.keyboard_backspace),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: size.width * .05),
                        child: Text(
                          language.dataJson[language.positionLanguage]["Politica"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ))
                  ]),
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  content: PoliticalText(language: language)));
        },
        child: Container(
            width: size.width * 0.7,
            height: size.height * 0.06,
            margin: EdgeInsets.only(bottom: size.height * 0.015),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(language.dataJson[language.positionLanguage]["Politica"],
                style: const TextStyle(fontSize: 21, color: Colors.black))));
  }
}

class TitlePageSetting extends StatelessWidget {
  final Size size;
  final String title;

  const TitlePageSetting({super.key, required this.size, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 0.09,
          top: size.height * 0.02,
          bottom: size.height * 0.02),
      width: size.width,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class InformationUser extends StatelessWidget {
  final Size size;
  final String title;
  final String subtitle;

  const InformationUser(
      {super.key,
      required this.size,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.00),
        width: size.width,
        child: ListTile(
          textColor: Colors.white,
          title: Text(title,
              style: const TextStyle(color: Colors.orange, fontSize: 25)),
          subtitle: AutoSizeText(
            maxLines: 1,
            subtitle,
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20),
          ),
        ));
  }
}

class ContainerButtonFunction extends StatelessWidget {
  final Size size;
  final Function functionCall;
  final String title;

  const ContainerButtonFunction(
      {super.key,
      required this.size,
      required this.functionCall,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => functionCall(),
      child: Container(
          width: size.width,
          height: size.height * 0.06,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.25, vertical: size.height * 0.02),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: AutoSizeText(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 20),
            maxLines: 1,
          )),
    );
  }
}

class ChangeCoolDropdown extends StatelessWidget {
  final Size size;
  final String type;
  final DropdownController dropdownController;
  final Function function;
  int position;
  final List<CoolDropdownItem<String>> dropdownItems;

  ChangeCoolDropdown(
      {super.key,
      required this.size,
      required this.type,
      required this.dropdownController,
      required this.position,
      required this.function,
      required this.dropdownItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.7,
      height: size.height * 0.06,
      margin: EdgeInsets.only(bottom: size.height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100,
            alignment: Alignment.centerLeft,
            child: Text(
              type,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ),
          CoolDropdown<String>(
            dropdownTriangleOptions: const DropdownTriangleOptions(
                borderRadius: 0, align: DropdownTriangleAlign.center, width: 0),
            controller: dropdownController,
            dropdownList: dropdownItems,
            defaultItem: dropdownItems[position],
            onChange: (value) => function(value),
            resultOptions: const ResultOptions(
              width: 100,
              render: ResultRender.label,
              openBoxDecoration: BoxDecoration(color: Colors.white),
              icon: SizedBox(
                width: 10,
                height: 10,
                child: CustomPaint(
                  painter: DropdownArrowPainter(
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            dropdownOptions: const DropdownOptions(
              width: 130,
            ),
            dropdownItemOptions: const DropdownItemOptions(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textStyle: TextStyle(color: Colors.black),
              selectedTextStyle: TextStyle(color: Colors.black),
              selectedBoxDecoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
