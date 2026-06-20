import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hop_navi/widgets/current_location.dart';
import 'package:latlong2/latlong.dart';

class LocationLayer extends StatelessWidget {
  final LatLng currentLocation;

  const LocationLayer({
    super.key, 
    required this.currentLocation,
  });
  // const LocationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
            width: 30.0,
            height: 30.0,
            point: LatLng(35.025438, 135.958355),   //仮座標
            child: Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.primary,
              size: 50,
            ),
          rotate: true,
        ),
        currentLocationMarker(context, currentLocation),
      ],
    );
  }
}