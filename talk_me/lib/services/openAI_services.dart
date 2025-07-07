import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey = 'sk-a4ecbb226e9c482ea890fd2f70c5671e';

  Future<String> sendMessage(String message) async {
    const url = 'https://api.deepseek.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "deepseek-chat",
        "messages": [
          {"role": "user", "content": message}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['choices'][0]['message']['content'];
    } else {
      throw Exception('Error al contactar la IA');
    }
  }
}
