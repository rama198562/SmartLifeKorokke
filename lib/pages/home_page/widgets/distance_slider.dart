import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/slider_provider.dart';

class DistanceSlider extends ConsumerWidget {
  const DistanceSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(distanceSliderProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '距離を選択',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),

        Slider(
          value: value,
          min: 1,
          max: 10,
          divisions: 9,
          label: '${value.round().toString()}km',
          onChanged: ((value) {
            ref.read(distanceSliderProvider.notifier).upgradeDistance(value);
          }
        )),
      ],
    );
  }
}