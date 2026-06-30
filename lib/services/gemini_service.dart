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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:latlong2/latlong.dart';
import '../models/route_model.dart'; 

class GeminiRouteResult {
  final String routeName;
  final String description;
  final List<String> selectedSpotNames;

  GeminiRouteResult({
    required this.routeName,
    required this.description,
    required this.selectedSpotNames,
  });

  factory GeminiRouteResult.fromJson(Map<String, dynamic> json) {
    return GeminiRouteResult(
      routeName: json['routeName'] ?? 'お散歩ルート',
      description: json['description'] ?? '',
      selectedSpotNames: List<String>.from(json['selectedSpotNames'] ?? []),
    );
  }
}

class GeminiService {
  Future<GeminiRouteResult> generateRouteFromList({
    required List<String> categories,
    required double distance,
    required String availableSpotsText,
    required String extraText,
    required String heiwadoInstruction,
  }) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      print('エラー: GEMINI_API_KEYが設定されていません');
      // フォールバック
      return GeminiRouteResult(
        routeName: 'エラー・予備ルート',
        description: 'APIキーが未設定です。',
        selectedSpotNames: [],
      );
    }

    final model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    const systemInstruction = '''
あなたは優秀なお散歩プランナーです。
ユーザーから【実在する周辺スポットの候補リスト】が渡されます。
必ず【そのリストの中にあるスポットだけ】を選んで、魅力的なお散歩ルートを提案してください。
リストにない場所は絶対に捏造しないでください。

以下のJSONフォーマットのみを出力してください。
selectedSpotNamesには、距離やカテゴリ【】を省いた、純粋なスポットの名前だけを含めてください。
{
  "routeName": "ルートのタイトル",
  "description": "ルートの魅力的な紹介文（※ここで距離が遠い場合のフォローなどを入れる）",
  "selectedSpotNames": ["選んだスポットの名前1", "選んだスポットの名前2"] 
}
''';

    final requestedCategories = categories.where((c) => c != '平和堂').join('、');
    
    String prompt = "現在地周辺の実在するスポットのリストです。以下のリストから、**実際の総移動距離（往復）が約${distance}kmになるように**、複数のスポットを経由する楽しいお散歩ルートを作ってください。\n\n"
        "【重要ルール】\n"
        "1. ユーザーは「$requestedCategories」を巡りたいと考えています。候補リストの【】を見て、必ず各カテゴリから最低1つは選んでください\n"
        "2. 遠すぎる場所を1つだけ選んで距離を稼ぐのはNGです。現在地から「近い場所」を複数（2〜4箇所）寄り道するように選んでください。\n"
        "3. リストの横の距離は「片道の直線距離」です。例えば現在地から ${distance/2}km の場所を1つ選ぶだけで往復 ${distance}km になるため、複数選ぶ場合はもっと近い場所を選ばないと距離を大きくオーバーします。\n\n"
        "候補:\n$availableSpotsText\n\n追加の要望: $extraText$heiwadoInstruction";

    try {
      final content = [Content.text('$systemInstruction\n\n$prompt')];
      final response = await model.generateContent(content);
      
      if (response.text != null) {
        final jsonMap = jsonDecode(response.text!) as Map<String, dynamic>;
        return GeminiRouteResult.fromJson(jsonMap);
      }
    } catch (e) {
      print('Gemini通信エラー: $e');
    }

    return GeminiRouteResult(
      routeName: '予備ルート',
      description: 'サーバー混雑時の予備ルートです',
      selectedSpotNames: [],
    );
  }
}