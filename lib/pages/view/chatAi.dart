import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tfgsaladillo/model/Message.dart';

class ChatAi extends StatefulWidget {
  const ChatAi({super.key});

  @override
  State<StatefulWidget> createState() => _ChatAi();
}

class _ChatAi extends State<ChatAi> {
  final TextEditingController _controller = TextEditingController();
  static const String apiKey = "AIzaSyA9RgM-495b9dsa4RLy2rp18aTT9tP_3TU";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  late final chatGpt;
  List<Message> listMessage = [];
  @override
  void initState() {
    chatGpt = model.startChat(history: [
      Content.text(
          'Eres un asistente chat bot de una aplicación movil, te vas a llamar TastyGPT, te dare un contexto  "La aplicación está destinada para una cadena de restaurantes, la aplicación tiene funcionalidades como tener un mapa de todas las ubicaciones de los restaurantes que están repartidos por toda España y en Gibraltar. Tiene 2 idiomas español y ingles. No tiene la opción de resarvar mesas, ni tampoco llevar a domicilio Sus platos son BurguerMax, BurguerUltra, Burguer Buey, Burguer Complete,The Ultimate Beef Burger,Harmony Burger,Veggie Delight,Breaded pepper,Shrimp Scampi,Vegetable cream,Vegetable taco,Scnizel, Iberic secret, Ragout, Meat balls, Fillet, Fried shrimp, Tilapia, Octo-Bite, Besugo, Octo-Grilled, Octo-chips, Coca cola,Coca cola zero, Fanta, Te"')
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.70),
                      Colors.transparent,
                      Colors.transparent
                    ]).createShader(bounds),
            blendMode: BlendMode.darken,
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage("assets/images/fondo.png"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.45),
                            BlendMode.darken))))),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                title: const Text("TastyGpt",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            body: SafeArea(
                child: Column(
              children: [
                Flexible(
                    child: ListView.builder(
                  reverse: true,
                  itemCount: listMessage.length,
                  itemBuilder: (context, index) {
                    return ViewMessage(
                      message: listMessage[index],
                    );
                  },
                )),
                Container(
                  margin: EdgeInsets.only(bottom: size.width * .05),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: size.width * .05),
                        width: size.width * .8,
                        height: size.height * 0.06,
                        decoration: const BoxDecoration(
                            color: Colors.white70,
                            borderRadius:
                                BorderRadius.all(Radius.circular(13))),
                        padding: EdgeInsets.all(size.width * .02),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              disabledBorder: null,
                              contentPadding: EdgeInsets.only(
                                  bottom: size.height * 0.01,
                                  left: size.width * 0.01),
                              hintText: "Envia un mensaje"),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            var texto = _controller.text;
                            _controller.clear();
                            if (texto.isNotEmpty) {
                              setState(() {
                                listMessage.insert(
                                    0, Message(text: texto, person: "person"));
                              });
                              var response = await chatGpt
                                  .sendMessage(Content.text(texto));
                              setState(() {
                                listMessage.insert(
                                    0,
                                    Message(
                                        text: response.text,
                                        person: "TastyDash"));
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 35,
                            color: Colors.white,
                          ))
                    ],
                  ),
                )
              ],
            )))
      ],
    );
  }
}

class ViewMessage extends StatelessWidget {
  final Message message;
  const ViewMessage({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.only(bottom: size.width * 0.02),
      child: Row(
        textDirection: message.person == "TastyDash"
            ? TextDirection.ltr
            : TextDirection.rtl,
        children: [
          Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            padding: EdgeInsets.all(size.width * 0.02),
            decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            margin: EdgeInsets.only(
                right: size.width * 0.02, left: size.width * 0.02),
            child: Image.asset(message.person == "TastyDash"
                ? "assets/images/ic_FORE.webp"
                : "assets/images/usuario.png"),
          ),
          Container(
            decoration: BoxDecoration(
              color: message.person == "TastyDash"
                  ? Colors.orange.shade700
                  : Colors.orange,
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: size.width * 0.55,
            padding: EdgeInsets.all(size.width * 0.05),
            child: Text(
              message.text,
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}
