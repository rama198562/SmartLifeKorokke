import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/category_grid_provider.dart';
import 'package:hop_navi/providers/route_loading_provider.dart';
import 'package:hop_navi/services/gemini_service.dart';

class RouteGenerateButton extends ConsumerWidget {
  const RouteGenerateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        final selectedIds = ref.read(categoryGridProvider);
        print('この条件でお散歩ルートを作る: $selectedIds');
        _onGenerateRouteRequested(context, ref);

      },
      child: const Text('ルートを生成する', style: TextStyle(fontSize: 16)),
    );
  }
}

Future<void> _onGenerateRouteRequested(BuildContext context, WidgetRef ref) async {
  //選ばれているカテゴリーを取得
  final selectedIds = ref.read(categoryGridProvider);

  if (selectedIds.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('カテゴリーを1つ以上選択してください')),
    );
    return;
  }

  ref.read(routeLoadingProvider.notifier).state = true;

  //選ばれた項目をで繋いでプロンプトにする
  final userRequest = "${selectedIds.join('、')}に立ち寄るお散歩ルートを提案してください。";
  print('Geminiへのリクエスト: $userRequest');

  // GeminiServiceを呼び出す
  final geminiService = GeminiService();
  final result = await geminiService.fetchRoutePreferences(userRequest);

  // 処理が終わったら Riverpod の状態を falseに戻す
  ref.read(routeLoadingProvider.notifier).state = false;

  if (!context.mounted) return;

  if (result != null) {
    print('--- Geminiからの解析結果（JSON） ---');
    print(result);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ルート解析成功: ${result['keywords'] ?? '完了'}')),
    );

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Geminiとの通信に失敗しました')),
    );
  }
}
