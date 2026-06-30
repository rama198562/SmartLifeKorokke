import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final locationProvider = StreamProvider.autoDispose<LocationData?>((ref) async* {
  Location location = Location();

  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      yield null;
      return;
    }
  }

  PermissionStatus permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      yield null;
      return;
    }
  }

  // 設定オプション（精度を高め、数秒ごとに取得するように設定）
  await location.changeSettings(accuracy: LocationAccuracy.high, interval: 3000, distanceFilter: 2);

  // まず初回の現在地を取得して通知
  final initialLocation = await location.getLocation();
  yield initialLocation;

  // 以降は現在地の変化を継続的にストリームで流す
  yield* location.onLocationChanged;
});