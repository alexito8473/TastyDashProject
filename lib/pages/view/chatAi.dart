import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tfgsaladillo/model/Message.dart';

class ChatAi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatAi();
}

class _ChatAi extends State<ChatAi> {
  late String texto = "prueba";
  static const String apikey = "AIzaSyDkSjMAYytLt60gO6mZKrj27m4Sf_MYk8g";
  final List<ChatMessage> _mensajes = [];
  final model = GenerativeModel(model: "gemini-pro", apiKey: apikey);
  final TextEditingController _controller = TextEditingController();

// Secret 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
  Future<void> _enviarMensaje() async {
    ChatMessage _message =
        ChatMessage(text: _controller.text, person: "Usuario");
    // final content=[Content.text(_controller.text)];
    // final response= await model.generateContent(content);
    // print(response.text);
    _controller.clear();
    setState(() {
      _mensajes.insert(0, _message);
      //  _mensajes.insert(0, ChatMessage(text: response.text??" ", person: "ChatBot"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("TastyGpt",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
        body: SafeArea(
            child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              reverse: true,
              itemCount: _mensajes.length,
              itemBuilder: (context, index) {
                return _mensajes[index];
              },
            )),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value) => _enviarMensaje(),
                    decoration: const InputDecoration.collapsed(
                        hintText: "Envia un mensaje"),
                  ),
                )),
                IconButton(
                    onPressed: () async {
                      await _enviarMensaje();
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ],
        )));
  }
}
