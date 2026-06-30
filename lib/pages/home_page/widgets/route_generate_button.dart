// lib/pages/home_page/widgets/route_generate_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/route_loading_provider.dart';
import 'package:hop_navi/pages/map_page/map_page.dart';
import 'package:hop_navi/providers/category_grid_provider.dart';
import 'package:hop_navi/providers/slider_provider.dart';
import 'package:hop_navi/providers/static_location_provider.dart';
import 'package:hop_navi/providers/text_input_provider.dart';

class RouteGenerateButton extends ConsumerWidget {
  const RouteGenerateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから状態を監視
    final isLoading = ref.watch(routeLoadingProvider);

    return ElevatedButton(
      onPressed: isLoading ? null : () async {
        // ボタンが押されたら状態を取得してProviderのロジックを実行！
        final categories = ref.read(categoryGridProvider).toList();
        final distance = ref.read(distanceSliderProvider);
        final currentLocation = ref.read(staticLocationProvider);
        final extraText = ref.read(textInputProvider);

        if (currentLocation == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('現在地を取得できません。')),
          );
          return;
        }

        final routeModel = await ref.read(routeLoadingProvider.notifier).generateAndGetRoute(
          categories, distance, currentLocation, extraText
        );

        // 無事にルートが作れたらマップ画面へ遷移！
        if (routeModel != null && context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(routeModel: routeModel),
            ),
          );
        }
      },
      child: isLoading 
          ? const SizedBox(
              width: 20, 
              height: 20, 
              child: CircularProgressIndicator(strokeWidth: 2)
            ) 
          : const Text('ルートを生成する'),
    );
  }
}