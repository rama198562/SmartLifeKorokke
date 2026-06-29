// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hop_navi/providers/category_grid_provider.dart';
// import 'package:hop_navi/providers/route_loading_provider.dart';
// import 'package:hop_navi/services/gemini_service.dart';

// class RouteGenerateButton extends ConsumerWidget {
//   const RouteGenerateButton({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         // minimumSize: const Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       onPressed: () {
//         final selectedIds = ref.read(categoryGridProvider);
//         print('この条件でお散歩ルートを作る: $selectedIds');
//         _onGenerateRouteRequested(context, ref);

//       },
//       child: const Text('ルートを生成する', style: TextStyle(fontSize: 16)),
//     );
//   }
// }

// Future<void> _onGenerateRouteRequested(BuildContext context, WidgetRef ref) async {
//   //選ばれているカテゴリーを取得
//   final selectedIds = ref.read(categoryGridProvider);

//   if (selectedIds.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('カテゴリーを1つ以上選択してください')),
//     );
//     return;
//   }

//   ref.read(routeLoadingProvider.notifier).state = true;

//   //選ばれた項目をで繋いでプロンプトにする
//   final userRequest = "${selectedIds.join('、')}に立ち寄るお散歩ルートを提案してください。";
//   print('Geminiへのリクエスト: $userRequest');

//   // GeminiServiceを呼び出す
//   final geminiService = GeminiService();
//   final result = await geminiService.fetchRoutePreferences(userRequest);

//   // 処理が終わったら Riverpod の状態を falseに戻す
//   ref.read(routeLoadingProvider.notifier).state = false;

//   if (!context.mounted) return;

//   if (result != null) {
//     print('--- Geminiからの解析結果（JSON） ---');
//     print(result);
    
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('ルート解析成功: ${result['keywords'] ?? '完了'}')),
//     );

//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Geminiとの通信に失敗しました')),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/category_grid_provider.dart';
import 'package:hop_navi/providers/route_loading_provider.dart';
import 'package:hop_navi/services/gemini_service.dart';
import 'package:hop_navi/pages/map_page/map_page.dart';
import 'package:hop_navi/providers/slider_provider.dart';
import 'package:hop_navi/providers/static_location_provider.dart';
import 'package:hop_navi/providers/map_location_provider.dart';
import 'package:hop_navi/providers/text_input_provider.dart';
import 'package:latlong2/latlong.dart';
// import 'package:hop_navi/models/route_model.dart'; // もし必要であればRouteModelをインポート

class RouteGenerateButton extends ConsumerWidget {
  const RouteGenerateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ローディング状態を監視して、通信中はボタンを押せなくする（デザイン変更可）
    final isLoading = ref.watch(routeLoadingProvider);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: isLoading ? null : () {
        _onGenerateRouteRequested(context, ref);
      },
      child: isLoading 
          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
          : const Text('ルートを生成する', style: TextStyle(fontSize: 16)),
    );
  }
}

Future<void> _onGenerateRouteRequested(BuildContext context, WidgetRef ref) async {
  // 選ばれているカテゴリーIDを取得 (['peak', 'cafe'] など)
  final selectedIds = ref.read(categoryGridProvider);

  if (selectedIds.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('カテゴリーを1つ以上選択してください')),
    );
    return;
  }

  final distance = ref.read(distanceSliderProvider);
  final extraText = ref.read(textInputProvider);
  // ローディング開始
  ref.read(routeLoadingProvider.notifier).state = true;

  LatLng? currentLocation = ref.read(staticLocationProvider);
  
  if (currentLocation == null) {
    // まだ取得できていない場合は、完了するまで待つ
    try {
      final locData = await ref.read(locationProvider.future);
      if (locData != null && locData.latitude != null && locData.longitude != null) {
        currentLocation = LatLng(locData.latitude!, locData.longitude!);
      }
    } catch (_) {}
  }

  if (currentLocation == null) {
    ref.read(routeLoadingProvider.notifier).state = false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('現在地が取得できませんでした')),
    );
    return;
  }

  // ① 英語のIDを日本語のタイトルに変換する（Geminiに分かりやすくするため）
  const categoryMap = {
    'peak': '公園',
    'convenience': 'コンビニ',
    'cafe': 'カフェ',
    'hospital': '病院',
  };
  final selectedTitles = selectedIds.map((id) => categoryMap[id] ?? id).toList();

  print('Geminiへリクエストするカテゴリー: $selectedTitles');

  // ローディング開始
  ref.read(routeLoadingProvider.notifier).state = true;

  // ② 改良したGeminiServiceを呼び出す
  final geminiService = GeminiService();
  final routeModel = await geminiService.generateRouteFromGemini(selectedTitles, distance, currentLocation, extraText);

  // ローディング終了
  ref.read(routeLoadingProvider.notifier).state = false;

  if (!context.mounted) return;

  if (routeModel != null) {
    print('--- Geminiからのルート生成結果 ---');
    print('ルート名: ${routeModel.routeName}');
    print('スポット数: ${routeModel.spots.length}');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ルート生成成功: ${routeModel.routeName}')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(routeModel: routeModel),
      ),
    );

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Geminiとの通信に失敗しました')),
    );
  }
}
