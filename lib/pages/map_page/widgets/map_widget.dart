import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/pages/map_page/widgets/location_layer.dart';
import 'package:hop_navi/pages/map_page/widgets/maproute_layer.dart';
import 'package:hop_navi/providers/map_location_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:hop_navi/models/route_model.dart'; 

class MapWidget extends ConsumerWidget  {
  final RouteModel? routeModel; // データを受け取る変数を追加

  // コンストラクタを修正して routeModel を受け取れるようにする
  const MapWidget({super.key, this.routeModel});

  // const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final locationAsyncValue = ref.watch(locationProvider);
    return locationAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
      data: (locationData) {
        if (locationData == null|| locationData.latitude == null || locationData.longitude == null || locationData.latitude!.isNaN ) {
          return const Center(child: Text('位置情報が取得できませんでした。'));
        }
    final currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    return FlutterMap(
      options: MapOptions(
        // アル・プラザ草津(仮)
        // initialCenter: LatLng(35.025438, 135.958355),
        initialCenter: currentLocation,
        //初期ズーム
        initialZoom: 18.0,
      ),
      children: [
        TileLayer(  //openstreetmap
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'korokke.osanpo',
          tileProvider: NetworkTileProvider(
            headers: {
              'Referer': 'https://github.com/rama198562/SmartLifeKorokke',
            },
          ),
        ),
        // LocationLayer(routeModel: routeModel),
        // MaprouteLayer(routeModel: routeModel),
        LocationLayer(currentLocation: currentLocation, routeModel: routeModel),
        MaprouteLayer(currentLocation: currentLocation, routeModel: routeModel),

      ],
    );
  });}
}