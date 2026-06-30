import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final locationProvider = StreamProvider.autoDispose<LocationData?>((ref) async* {
  Location location = Location();

  print('locationProvider: サービス開始確認');
  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    print('locationProvider: サービス無効。リクエストします。');
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      print('locationProvider: サービスが有効になりませんでした。');
      yield null;
      return;
    }
  }

  print('locationProvider: 権限確認');
  PermissionStatus permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    print('locationProvider: 権限拒否されています。リクエストします。');
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      print('locationProvider: 権限が付与されませんでした。');
      yield null;
      return;
    }
  }

  print('locationProvider: 現在地取得開始 (location.getLocation)');
  // 設定オプション（精度を高め、数秒ごとに取得するように設定）
  await location.changeSettings(accuracy: LocationAccuracy.high, interval: 3000, distanceFilter: 2);

  // まず初回の現在地を取得して通知
  final initialLocation = await location.getLocation();
  print('locationProvider: 現在地取得成功: ${initialLocation.latitude}, ${initialLocation.longitude}');
  yield initialLocation;

  // 以降は現在地の変化を継続的にストリームで流す
  yield* location.onLocationChanged;
});