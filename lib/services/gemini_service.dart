import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  // 外部からユーザーの要望を受け取って、解析結果のJSON（Map型）を返す関数
  Future<Map<String, dynamic>?> fetchRoutePreferences(String userRequest) async {
    final apiKey = String.fromEnvironment('GEMINI_API_KEY'); 
    if (apiKey.isEmpty) return null;

    final model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    const systemInstruction = '''
ユーザーからお散歩の要望が届きます。
以下の項目を含むJSONフォーマットだけで出力してください。

【出力JSONフォーマット】
{
  "keywords": ["重視するキーワード（英語）"],
  "avoid_highways": trueまたはfalse,
  "max_duration_minutes": 推定される所要時間（数値）
}
''';

    try {
      final content = [Content.text('$systemInstruction\n\nユーザーの要望: $userRequest')];
      final response = await model.generateContent(content);
      if (response.text != null) {
        return jsonDecode(response.text!) as Map<String, dynamic>;
      }
    } catch (e) {
      print('Gemini通信エラー: $e');
    }
    return null;
  }
}
