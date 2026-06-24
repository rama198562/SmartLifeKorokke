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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LatLng>>(
      future: OrsApiService.getStrollerRoute(
        currentLocation: currentLocation,
        routeModel: routeModel,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink(); 
        }

        final routePoints = snapshot.data ?? [];

        if (routePoints.isEmpty) {
          return PolylineLayer(polylines: const <Polyline>[]); 
        }

        return PolylineLayer(
          polylines: [
            Polyline(
              points: routePoints,
              strokeWidth: 6.0, 
              color: Theme.of(context).colorScheme.primary,
              borderStrokeWidth: 2.0,
              borderColor: Theme.of(context).colorScheme.secondary
            ),
          ],
        );
      },
    );
  }
}