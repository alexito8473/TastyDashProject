import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Person.dart';

import '../../models/Coin.dart';
import '../widget/settingViewWidget.dart';

class SettingView extends StatefulWidget {
  final Function disconnected;
  final Function changeCoin;
  final Function changeLanguage;
  final Function navigationLogin;
  final DropdownController languageDropdownController;
  final List<CoolDropdownItem<String>> languageDropdownItems;
  final DropdownController coinDropdownController;
  final List<CoolDropdownItem<String>> coinDropdownItems;
  final List<Coin> coins;
  final Language language;
  final Size size;
  final ImageProvider imageBannerSettings;
  Coin coin;
  final Person? person;

  SettingView(
      {super.key,
      required this.disconnected,
      required this.changeCoin,
      required this.changeLanguage,
      required this.navigationLogin,
      required this.size,
      required this.imageBannerSettings,
      required this.language,
      required this.person,
      required this.languageDropdownController,
      required this.languageDropdownItems,
      required this.coinDropdownController,
      required this.coinDropdownItems,
      required this.coins,
      required this.coin});

  @override
  State<SettingView> createState() => _SettingView();
}

class _SettingView extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: widget.imageBannerSettings,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken))),
      child: ListView(children: [
        TitlePageSetting(
            size: widget.size,
            title: widget.language.dataJson[widget.language.positionLanguage]
                ["MiCuenta"]),
        if (widget.person != null)
          InformationUser(
            size: widget.size,
            title: widget.language.dataJson[widget.language.positionLanguage]
                ["Nombre"],
            subtitle: widget.person!.name,
          ),
        if (widget.person != null)
          InformationUser(
              size: widget.size,
              title: "E-mail",
              subtitle: widget.person!.gmail),
        widget.person != null
            ? ContainerButtonFunction(
                size: widget.size,
                functionCall: widget.disconnected,
                title: widget.language.dataJson[widget.language.positionLanguage]
                    ["Cerrar_sesion"])
            : ContainerButtonFunction(
                size: widget.size,
                functionCall: widget.navigationLogin,
                title: widget.language.dataJson[widget.language.positionLanguage]
                    ["Iniciar_sesion"]),

              TitlePageSetting(
                  size: widget.size,
                  title: widget.language.dataJson[widget.language.positionLanguage]
                      ["Ajustes"]),
              // Change language
              ChangeCoolDropdown(
                  size: widget.size,
                  type: widget.language.dataJson[widget.language.positionLanguage]
                      ["Idioma"],
                  dropdownController: widget.languageDropdownController,
                  position: widget.language.positionLanguage,
                  function: widget.changeLanguage,
                  dropdownItems: widget.languageDropdownItems),
              // Change coin
              ChangeCoolDropdown(
                  size: widget.size,
                  type: widget.language.dataJson[widget.language.positionLanguage]
                      ["Moneda"],
                  dropdownController: widget.coinDropdownController,
                  position: widget.coins.indexOf(widget.coin),
                  function: widget.changeCoin,
                  dropdownItems: widget.coinDropdownItems),
              ButtonTermOfUse(
                language: widget.language,
                size: widget.size,
              ),
              if(widget.person!=null)
              ButtonTastyGpt(size: widget.size, language: widget.language,),

      ]),
    );
  }
}
