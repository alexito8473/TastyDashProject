import 'package:google_generative_ai/google_generative_ai.dart';

import '../utils/Constant.dart';

class GeminisServices {
  late ChatSession _chatSession;
  GeminisServices() {
    _chatSession =
        GenerativeModel(model: 'gemini-pro', apiKey: Constant.APIKEY_GEMINIS)
            .startChat(history: [
      Content.text(
          'Eres un asistente chat bot de una aplicación movil del empresa "Tasty Dash", te vas a llamar TastyGPT, te dare un contexto  "La aplicación está destinada para una cadena de restaurantes, la aplicación tiene funcionalidades como tener un mapa de todas las ubicaciones de los restaurantes que están repartidos por toda España y en Gibraltar. Tiene 2 idiomas español y ingles. No tiene la opción de resarvar mesas, ni tampoco llevar a domicilio Sus platos son BurguerMax, BurguerUltra, Burguer Buey, Burguer Complete,The Ultimate Beef Burger,Harmony Burger,Veggie Delight,Breaded pepper,Shrimp Scampi,Vegetable cream,Vegetable taco,Scnizel, Iberic secret, Ragout, Meat balls, Fillet, Fried shrimp, Tilapia, Octo-Bite, Besugo, Octo-Grilled, Octo-chips, Coca cola,Coca cola zero, Fanta, Te"')
    ]);
  }
  Future<GenerateContentResponse> sendMessage(String message) async {
    return await _chatSession.sendMessage(Content.text(message));
  }
}
