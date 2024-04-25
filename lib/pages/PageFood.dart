import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/model/Comida.dart';

class PaginaComida extends StatefulWidget{
  final Comida comida;
  const PaginaComida({super.key, required this.comida});
  @override
  State<StatefulWidget> createState() =>_PaginaComida();
}
class _PaginaComida extends State<PaginaComida>{
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      body:  Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    width: size.width,
                    child:
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: AssetImage(widget.comida.foto),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  isAntiAlias: true)),
                          height: size.height*0.4,
                        )
                    ),
                Container(
                  width: size.width,
                  height: size.height,
                  margin:  EdgeInsets.only(top:  size.height*0.35,),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                  ),
                  child:   SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: size.width*0.1,top: size.height*0.05),
                                  alignment: Alignment.centerLeft,
                                  child: Text(widget.comida.nombre,style: TextStyle(color: Colors.black,fontSize: 30),)
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: size.width*0.1,top: size.height*0.05),
                                  alignment: Alignment.centerLeft,
                                  child: Text((widget.comida.precio).toString(),style: TextStyle(color: Colors.black,fontSize: 30),)
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                ),
              ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            elevation: 10,
            backgroundColor: Colors.orange,
            child: const Icon(FontAwesomeIcons.arrowLeft),
          ),
    );
  }

}
