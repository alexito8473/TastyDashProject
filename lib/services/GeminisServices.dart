import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tfgsaladillo/models/Language.dart';
import '../utils/Constant.dart';

class GeminisServices {
  late ChatSession _chatSession;

  // Constructor initializes a chat session with Gemini's generative model
  GeminisServices(Language language) {
    // Start a new chat session using the GenerativeModel with Gemini-pro model and API key
    _chatSession = GenerativeModel(
      model: 'gemini-pro',
      apiKey: Constant.APIKEY_GEMINIS,
    ).startChat(
      history: [
        Content.text(
          language.dataJson[language.positionLanguage]["CHAT_AI_INITIAL_TEXT"],
        ),
      ],
    );
  }

  // Sends a message to the chat session and returns the response asynchronously
  Future<GenerateContentResponse> sendMessage(String message) async {
    return await _chatSession.sendMessage(Content.text(message));
  }
}

