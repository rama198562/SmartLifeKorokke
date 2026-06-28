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

  List<LatLng> _offsetPoints(List<LatLng> points, double offsetMeters) {
    if (points.length < 2) return points;
    final Distance distance = const Distance();
    List<LatLng> result = [];
    for (int i = 0; i < points.length; i++) {
      double bearing;
      if (i < points.length - 1) {
        bearing = distance.bearing(points[i], points[i + 1]);
      } else {
        bearing = distance.bearing(points[i - 1], points[i]);
      }
      // 進行方向に対して左側にずらすため -90度
      result.add(distance.offset(points[i], offsetMeters, bearing - 90));
    }
    return result;
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
              ? Colors.orange.withValues(alpha: 0.8) // フレンドマート以降の色（オレンジ）
              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.7);

          List<LatLng> points = routeSegments[i];
          // 帰り道（フレンドマート以降）は進行方向の左側に少し(約10m)ずらす
          if (isAfterFriendMart) {
            points = _offsetPoints(points, 5.0);
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