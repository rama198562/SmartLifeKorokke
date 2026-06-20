// import 'dart:convert';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import '../models/route_model.dart'; // インポートを一番上にまとめました

// class GeminiService {
//   // === 【あなた（繋ぎ役）が作った関数】 ===
//   Future<Map<String, dynamic>?> fetchRoutePreferences(String userRequest) async {
//     final apiKey = String.fromEnvironment('GEMINI_API_KEY'); 
//     if (apiKey.isEmpty) return null;

//     final model = GenerativeModel(
//       model: 'gemini-3.5-flash',
//       apiKey: apiKey,
//       generationConfig: GenerationConfig(responseMimeType: 'application/json'),
//     );

//     const systemInstruction = '''
// ユーザーからお散歩の要望が届きます。
// 以下の項目を含むJSONフォーマットだけで出力してください。

// 【出力JSONフォーマット】
// {
//   "keywords": ["重視するキーワード（英語）"],
//   "avoid_highways": trueまたはfalse,
//   "max_duration_minutes": 推定される所要時間（数値）
// }
// ''';

//     try {
//       final content = [Content.text('$systemInstruction\n\nユーザーの要望: $userRequest')];
//       final response = await model.generateContent(content);
//       if (response.text != null) {
//         return jsonDecode(response.text!) as Map<String, dynamic>;
//       }
//     } catch (e) {
//       print('Gemini通信エラー: $e');
//     }
//     return null;
//   } // ← ここで綺麗にあなたの関数とクラスを閉じられるように整理しました

//   // === 【Gemini担当の人が作った最新の関数】 ===
//   Future<RouteModel> generateRoute() async {
//     final json = {
//       "routeName": "公園散歩ルート",
//       "description": "公園を経由するルート",
//       "spots": [
//         {
//           "name": "sample公園",
//           "type": "park"
//         },
//         {
//           "name": "sample神社",
//           "type": "landmark"
//         }
//       ]
//     };

//     return RouteModel.fromJson(json);
//   }
// }

// import 'dart:convert';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import '../models/route_model.dart'; 

// class GeminiService {
//   // ① 選択されたカテゴリー（日本語）を受け取り、RouteModelを返す関数
//   Future<RouteModel?> generateRouteFromGemini(List<String> selectedCategories) async {
//     final apiKey = const String.fromEnvironment('GEMINI_API_KEY'); 
//     if (apiKey.isEmpty) {
//       print('エラー: GEMINI_API_KEYが設定されていません');
//       return null;
//     }

//     final model = GenerativeModel(
//       model: 'gemini-3.5-flash',
//       apiKey: apiKey,
//       // 必ずJSONフォーマットで返すように設定
//       generationConfig: GenerationConfig(responseMimeType: 'application/json'),
//     );

//     // ② RouteModelの構造にピタリと合うJSONを出力するようにGeminiに強制するプロンプト
//     const systemInstruction = '''
// あなたは優秀な旅行・お散歩プランナーです。
// ユーザーから渡されたカテゴリー（例：公園、カフェなど）に立ち寄る、魅力的なお散歩ルートを提案してください。
// 必ず以下のJSONフォーマットのみを出力してください。

// 【出力JSONフォーマット】
// {
//   "routeName": "ルートのタイトル（例: 休日のリラックス公園ルート）",
//   "description": "ルートの簡単な説明やアピールポイント",
//   "spots": [
//     {
//       "name": "立ち寄る具体的なスポット名（架空でも可）",
//       "type": "スポットのカテゴリー（英語表記 例: park, cafe, hospital, convenience 等）"
//     }
//   ]
// }
// ''';

//     // ユーザーのリクエスト文を作成
//     final userRequest = "${selectedCategories.join('、')}に立ち寄るお散歩ルートを提案してください。";

//     try {
//       final content = [Content.text('$systemInstruction\n\nユーザーの要望: $userRequest')];
//       final response = await model.generateContent(content);
      
//       if (response.text != null) {
//         // ③ Geminiが返したJSON文字列をDartのMapに変換
//         final jsonMap = jsonDecode(response.text!) as Map<String, dynamic>;
//         // ④ MapをそのままRouteModelに変換して返す
//         return RouteModel.fromJson(jsonMap);
//       }
//     } catch (e) {
//       print('Gemini通信エラー: $e');
//     }
//     return null;
//   }
// }

import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/route_model.dart'; 

class GeminiService {
  Future<RouteModel?> generateRouteFromGemini(List<String> selectedCategories) async {
    final apiKey = const String.fromEnvironment('GEMINI_API_KEY'); 
    if (apiKey.isEmpty) {
      print('エラー: GEMINI_API_KEYが設定されていません');
      return null;
    }

    final model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    // 💡 修正: 草津周辺を指定し、latitude と longitude を出力させる
    const systemInstruction = '''
あなたは優秀な旅行・お散歩プランナーです。
ユーザーから渡されたカテゴリー（例：公園、カフェなど）に立ち寄るお散歩ルートを提案してください。
今回は「滋賀県の草津駅周辺（緯度: 35.025, 経度: 135.958 付近）」を想定して、実在しそうなスポットと、そのリアルな緯度・経度を含めてください。
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

    final userRequest = "${selectedCategories.join('、')}に立ち寄るお散歩ルートを提案してください。";

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