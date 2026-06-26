import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/slider_provider.dart';

class DistanceSlider extends ConsumerWidget {
  const DistanceSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(distanceSliderProvider);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '距離を選択',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,

              ),
            ),
          ],
        ),
        SliderTheme(
          data:SliderTheme.of(context).copyWith(
            activeTickMarkColor: colorScheme.secondary,
            trackHeight: 10.0,
            valueIndicatorColor: colorScheme.primary,
            valueIndicatorTextStyle: TextStyle(
              color: colorScheme.secondary, 
              fontSize: 12,
            ),
          ),
          child: Slider(
            value: value,
            min: 1,
            max: 4,
            divisions: 3,
            label: '${value.round().toString()}km',
            onChanged: ((value) {
              ref.read(distanceSliderProvider.notifier).upgradeDistance(value);
            }
          )),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1km(15分)', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('4km(1時間)', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),

      ],
    );
  }
}