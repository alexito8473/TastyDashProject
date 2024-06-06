import 'package:flutter/material.dart';
import 'package:tfgsaladillo/models/Language.dart';
import 'package:tfgsaladillo/models/Message.dart';
import 'package:tfgsaladillo/services/GeminisServices.dart';

class ChatAi extends StatefulWidget {
  final Language language;
  const ChatAi({super.key, required this.language});

  @override
  State<StatefulWidget> createState() => _ChatAiState();
}

class _ChatAiState extends State<ChatAi> {
  final TextEditingController _controller = TextEditingController();
  final GeminisServices gemini = GeminisServices();
  List<Message> listMessage = [];

  void communication() async {
    String? response;
    var text = _controller.text;
    _controller.clear();
    if (text.isNotEmpty) {
      setState(() {
        listMessage.insert(
            0,
            Message(
                text: text,
                person: widget.language
                    .dataJson[widget.language.positionLanguage]["PERSON"]));
      });
      response = (await gemini.sendMessage(text)).text;
      setState(() {
        listMessage.insert(
            0,
            Message(
                text: response ?? widget.language
                    .dataJson[widget.language.positionLanguage]["GEMINI_ERROR"],
                person: "TastyDash"));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                              hintText: widget.language
                                  .dataJson[widget.language.positionLanguage]["GEMINI_TEXT_HINT"]),
                        ),
                      ),
                      IconButton(
                          onPressed: () => communication(),
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
              style: const TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
