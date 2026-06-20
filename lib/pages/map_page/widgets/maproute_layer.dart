// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class MaprouteLayer extends StatelessWidget {
//   const MaprouteLayer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PolylineLayer(
//     polylines: [
//         Polyline(
//           points: [ //仮ルート
//               const LatLng(35.025634, 135.957575),
//               const LatLng(35.025042, 135.957082),
//               const LatLng(35.025437, 135.956315),
//               const LatLng(35.024083, 135.955220),
//           ],
//           strokeWidth: 3.0,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//     ],
//   );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:hop_navi/models/route_model.dart'; // 👈 RouteModelをインポート

class MaprouteLayer extends StatelessWidget {
  final RouteModel? routeModel; // 👈 データを受け取る

  const MaprouteLayer({super.key, this.routeModel});

  @override
  Widget build(BuildContext context) {
    // スタート地点: アル・プラザ草津
    final startPoint = const LatLng(35.025438, 135.958355);
    List<LatLng> routePoints = [startPoint];

    // 💡 Geminiが考えたスポットの座標を順番に線で結ぶ！
    if (routeModel != null && routeModel!.spots.isNotEmpty) {
      for (var spot in routeModel!.spots) {
        routePoints.add(LatLng(spot.latitude, spot.longitude));
      }
    } else {
      // データがない時はダミーの線
      routePoints = [
        const LatLng(35.025634, 135.957575),
        const LatLng(35.025042, 135.957082),
        const LatLng(35.025437, 135.956315),
        const LatLng(35.024083, 135.955220),
      ];
    }

    return PolylineLayer(
      polylines: [
        Polyline(
          points: routePoints,
          strokeWidth: 4.0, // 線を少し太くすると見栄えが良いです
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}