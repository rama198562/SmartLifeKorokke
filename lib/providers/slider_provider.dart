import 'package:flutter_riverpod/flutter_riverpod.dart';

final distanceSliderProvider = NotifierProvider.autoDispose<DistanceSlider, double>(DistanceSlider.new);


class DistanceSlider extends Notifier<double> {
  @override
  double build() {
    return 1.0;
  }
  void upgradeDistance(double newValue) {
    state = newValue;
  }
}

