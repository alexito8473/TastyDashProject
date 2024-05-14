import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Person.dart';

import '../../model/Moneda.dart';
import '../widget/settingViewWidget.dart';

class SettingView extends StatefulWidget {
  final Function funDesbloquearte;
  final Function funCambiarMoneda;
  final Function funCambiarIdioma;
  final Function funNavegarLogin;
  final DropdownController lenguageDropdownController;
  final List<CoolDropdownItem<String>> lenguageDropdownItems;
  final DropdownController monedaDropdownController;
  final List<CoolDropdownItem<String>> monedaDropdownItems;
  final List<Moneda> monedas;
  final Idioma idioma;
  final Size size;
  final ImageProvider imagenBannerAjustes;
  Moneda monedEnUso;
  final Person? person;

  SettingView(
      {super.key,
      required this.funDesbloquearte,
      required this.funCambiarMoneda,
      required this.funCambiarIdioma,
      required this.funNavegarLogin,
      required this.size,
      required this.imagenBannerAjustes,
      required this.idioma,
      required this.person,
      required this.lenguageDropdownController,
      required this.lenguageDropdownItems,
      required this.monedaDropdownController,
      required this.monedaDropdownItems,
      required this.monedas,
      required this.monedEnUso});

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
              image: widget.imagenBannerAjustes,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken))),
      child: ListView(children: [
        TituloPageSetting(
            size: widget.size,
            title: widget.idioma.datosJson[widget.idioma.positionIdioma]
                ["MiCuenta"]),
        if (widget.person != null)
          InformacionUsuarioSetting(
              size: widget.size,
              title: widget.idioma.datosJson[widget.idioma.positionIdioma]
                  ["Nombre"],
              subtitle: widget.person!.nombre),
        if (widget.person != null)
          InformacionUsuarioSetting(
              size: widget.size,
              title: "E-mail",
              subtitle: widget.person!.gmail),
        widget.person != null
            ? ContaninerButtonFunction(
                size: widget.size,
                functionCall: widget.funDesbloquearte,
                titulo: widget.idioma.datosJson[widget.idioma.positionIdioma]
                    ["Cerrar_sesion"])
            : ContaninerButtonFunction(
                size: widget.size,
                functionCall: widget.funNavegarLogin,
                titulo: "Iniciar sesión"),
        Container(
          height: widget.size.height * 0.9,
          margin: EdgeInsets.only(top: widget.size.height * 0.02),
          child: Column(
            children: [
              TituloPageSetting(
                  size: widget.size,
                  title: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["MiCuenta"]),
              CambioCoolDropdown(
                  size: widget.size,
                  type: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["Idioma"],
                  dropdownController: widget.lenguageDropdownController,
                  position: widget.idioma.positionIdioma,
                  function: widget.funCambiarIdioma,
                  dropdownItems: widget.lenguageDropdownItems),
              CambioCoolDropdown(
                  size: widget.size,
                  type: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["Moneda"],
                  dropdownController: widget.monedaDropdownController,
                  position: widget.monedas.indexOf(widget.monedEnUso),
                  function: widget.funCambiarMoneda,
                  dropdownItems: widget.monedaDropdownItems),
              BotonTerminosDeUso(
                idioma: widget.idioma,
                size: widget.size,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
