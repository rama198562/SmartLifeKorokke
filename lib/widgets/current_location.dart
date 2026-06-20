import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

Marker currentLocationMarker(BuildContext context, LatLng position) {
  final colorScheme = Theme.of(context).colorScheme;
  
  return Marker(
    point: position,
    width: 40,
    height: 40,
    child: Container(
      decoration: BoxDecoration(
        color:colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color:colorScheme.secondary,
            shape: BoxShape.circle,
            border:Border.all(),
          ),
        ),
      ),
    ),
  );
}