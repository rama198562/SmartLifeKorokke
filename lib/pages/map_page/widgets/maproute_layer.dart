import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:hop_navi/models/route_model.dart';
import 'package:hop_navi/services/ors_service.dart';

class MaprouteLayer extends StatelessWidget {
  final LatLng currentLocation;
  final RouteModel? routeModel;

  const MaprouteLayer({
    super.key,
    required this.currentLocation,
    this.routeModel,
  });

  List<LatLng> _offsetPoints(List<LatLng> points) {
    // 複雑な方位計算によるNaNエラーを完全に防ぐため、
    // 単純に緯度・経度に微小な値を足して線をずらします。（約10m強のズレ）
    const double offsetDegrees = 0.00005; 
    return points.map((p) {
      if (p.latitude.isNaN || p.longitude.isNaN) return p;
      return LatLng(p.latitude + offsetDegrees, p.longitude + offsetDegrees);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<LatLng>>>(
      future: OrsApiService.getStrollerRoute(
        currentLocation: currentLocation,
        routeModel: routeModel,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink(); 
        }

        final routeSegments = snapshot.data ?? [];

        if (routeSegments.isEmpty) {
          return PolylineLayer(polylines: const <Polyline>[]); 
        }

        // フレンドマートのインデックスを探す
        int friendMartIndex = -1;
        if (routeModel != null) {
          for (int i = 0; i < routeModel!.spots.length; i++) {
            if (routeModel!.spots[i].name.contains('フレンドマート')) {
              friendMartIndex = i;
              break;
            }
          }
        }

        final polylines = <Polyline>[];
        for (int i = 0; i < routeSegments.length; i++) {
          bool isAfterFriendMart = friendMartIndex != -1 && i > friendMartIndex;

          Color segmentColor = isAfterFriendMart
              ? Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.7)
              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.7);

          List<LatLng> points = routeSegments[i];
          // 帰り道（フレンドマート以降）は進行方向の左側に少しずらす
          if (isAfterFriendMart) {
            points = _offsetPoints(points);
          }

          polylines.add(
            Polyline(
              points: points,
              strokeWidth: 6.0, 
              color: segmentColor,
              borderStrokeWidth: 2.0,
              borderColor: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7),
              strokeCap: StrokeCap.round,
              strokeJoin: StrokeJoin.round,
            ),
          );
        }

        return PolylineLayer(polylines: polylines);
      },
    );
  }
}