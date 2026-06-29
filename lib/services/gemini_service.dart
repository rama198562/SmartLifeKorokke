

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:latlong2/latlong.dart';
import '../models/route_model.dart'; 

class GeminiService {
  Future<RouteModel?> generateRouteFromGemini(List<String> selectedCategories, double distance, LatLng currentLocation, String extraText) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      print('エラー: GEMINI_API_KEYが設定されていません');
      return null;
    }

    final model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

        const systemInstruction = '''
あなたは優秀なお散歩プランナーです。
ユーザーから渡されたカテゴリー（例：公園、カフェなど）と距離でに立ち寄るお散歩ルートを提案してください。
お散歩ルートは現在地から近いカテゴリーから選んだスポットと必ず一番現在地から距離が近い平和堂またはフレンドマートまたはアル・プラザで挟み込むようにしてください。
例えば、カフェと公園を指定されていた場合、現在地、カフェ１、公園、フレンドマート、カフェ２，最初にいた現在地のように必ず最初の現在地に戻ってくるようにしてください。
また、帰りはできるだけ別の道から帰るようにしてください
そこから経由地のデータを以下のようにjsonで返してください。
実在する場所とその場所の緯度経度の情報は絶対に嘘をつかないでください
extraTextでの追加情報はどんなことよりも絶対優先させるようにしてください
もし、指定された距離の範囲内に平和堂またはフレンドマートまたはアル・プラザが存在しなかった場合は、その旨をdescriptionに記載して含まないルートにしてください
必ず以下のJSONフォーマットのみを出力してください。

【出力JSONフォーマット】
{
  "routeName": "ルートのタイトル（例: 休日のリラックス公園ルート）",
  "description": "ルートの簡単な説明やアピールポイント",
  "spots": [
    {
      "name": "立ち寄る具体的なスポット名",
      "type": "スポットのカテゴリー（英語表記 例: park, cafe, hospital, convenience 等）",
      "latitude": 35.026123,
      "longitude": 135.959345
    }
  ]
}
''';

    // 💡 修正: 草津周辺を指定し、latitude と longitude を出力させる
//     const systemInstruction = '''
// あなたは優秀な旅行・お散歩プランナーです。
// ユーザーから渡されたカテゴリー（例：公園、カフェなど）に立ち寄るお散歩ルートを提案してください。
// 今回は「滋賀県の草津駅周辺（緯度: 35.025, 経度: 135.958 付近）」を想定して、実在しそうなスポットと、そのリアルな緯度・経度を含めてください。
// 必ず以下のJSONフォーマットのみを出力してください。

// 【出力JSONフォーマット】
// {
//   "routeName": "ルートのタイトル（例: 休日のリラックス公園ルート）",
//   "description": "ルートの簡単な説明やアピールポイント",
//   "spots": [
//     {
//       "name": "立ち寄る具体的なスポット名",
//       "type": "スポットのカテゴリー（英語表記 例: park, cafe, hospital, convenience 等）",
//       "latitude": 35.026123,
//       "longitude": 135.959345
//     }
//   ]
// }
// ''';

    final userRequest = "現在地（緯度: ${currentLocation.latitude}, 経度: ${currentLocation.longitude}）から距離${distance}km圏内で、${selectedCategories.join('、')}に立ち寄るお散歩ルートを提案してください。${extraText.isNotEmpty ? '\\n追加の要望: $extraText' : ''}";

    try {
      final content = [Content.text('$systemInstruction\n\nユーザーの要望: $userRequest')];
      final response = await model.generateContent(content);
      
      if (response.text != null) {
        final jsonMap = jsonDecode(response.text!) as Map<String, dynamic>;
        return RouteModel.fromJson(jsonMap);
      }
    } catch (e) {
      print('Gemini通信エラー: $e');
      
      // 💡 追加: サーバー混雑時（エラー時）は、このダミーデータを返す！
      print('サーバー混雑のため、バックアップルートを返します');
      return RouteModel(
        routeName: '草津駅周辺 リフレッシュお散歩ルート (予備)',
        description: 'Geminiサーバー混雑時の予備ルートです',
        spots: [
          SpotModel(name: '草津川跡地公園', type: 'park', latitude: 35.022300, longitude: 135.961200),
          SpotModel(name: '近くのカフェ', type: 'cafe', latitude: 35.024500, longitude: 135.959800),
          SpotModel(name: '駅前コンビニ', type: 'convenience', latitude: 35.031500, longitude: 135.962500),
        ],
      );
    }
    return null;
  }
}