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
            max: 10,
            divisions: 9,
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
              Text('1km', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('5km', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('10km', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),

      ],
    );
  }
}