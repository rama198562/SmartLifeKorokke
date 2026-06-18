import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MaprouteLayer extends StatelessWidget {
  const MaprouteLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return PolylineLayer(
    polylines: [
        Polyline(
          points: [ //仮ルート
              const LatLng(35.025634, 135.957575),
              const LatLng(35.025042, 135.957082),
              const LatLng(35.025437, 135.956315),
              const LatLng(35.024083, 135.955220),
          ],
          strokeWidth: 3.0,
          color: Theme.of(context).colorScheme.primary,
        ),
    ],
  );
  }
}