import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Person.dart';
import '../model/Moneda.dart';

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
              /*
                            FloatingActionButton(
                              heroTag: null,
                              onPressed: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  reverseTransitionDuration:
                                      const Duration(milliseconds: 500),
                                  barrierColor: Colors.black54,
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: ChatAi(),
                                    );
                                  },
                                ));
                              },
                            )
                            */
            ],
          ),
        )
      ]),
    );
  }
}

class PoliticaTexto extends StatelessWidget {
  final Idioma idioma;
  const PoliticaTexto({super.key, required this.idioma});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width * .8,
        height: size.height * .7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
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
                        idioma.datosJson[idioma.positionIdioma]["Politica"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ))
                ]),
              ),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text1"],
                  style: const TextStyle(fontSize: 18)),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text2"],
                  style: const TextStyle(fontSize: 18)),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text3"],
                  style: const TextStyle(fontSize: 18)),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text4"],
                  style: const TextStyle(fontSize: 18)),
              Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text5"],
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        ));
  }
}

class BotonTerminosDeUso extends StatelessWidget {
  final Idioma idioma;
  final Size size;
  const BotonTerminosDeUso(
      {super.key, required this.idioma, required this.size});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              barrierDismissible: false,
              barrierColor: Colors.black.withOpacity(0.6),
              useSafeArea: false,
              context: context,
              builder: (context) =>
                  AlertDialog(content: PoliticaTexto(idioma: idioma)));
        },
        child: Container(
            width: size.width * 0.7,
            height: size.height * 0.06,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(idioma.datosJson[idioma.positionIdioma]["Politica"],
                style: const TextStyle(fontSize: 21, color: Colors.black))));
  }
}

class TituloPageSetting extends StatelessWidget {
  final Size size;
  final String title;
  TituloPageSetting({super.key, required this.size, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 0.09,
          top: size.height * 0.05,
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

class InformacionUsuarioSetting extends StatelessWidget {
  final Size size;
  final String title;
  final String subtitle;
  InformacionUsuarioSetting(
      {super.key,
      required this.size,
      required this.title,
      required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.01),
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

class ContaninerButtonFunction extends StatelessWidget {
  final Size size;
  final Function functionCall;
  final String titulo;
  const ContaninerButtonFunction(
      {super.key,
      required this.size,
      required this.functionCall,
      required this.titulo});
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
            titulo,
            style: const TextStyle(color: Colors.black, fontSize: 20),
            maxLines: 1,
          )),
    );
  }
}

class CambioCoolDropdown extends StatelessWidget {
  final Size size;
  final String type;
  final DropdownController dropdownController;
  final Function function;
  int position;
  final List<CoolDropdownItem<String>> dropdownItems;
  CambioCoolDropdown(
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
