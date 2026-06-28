
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/providers/map_location_provider.dart';
import 'package:latlong2/latlong.dart';

final staticLocationProvider = Provider((ref){
  final locationAsyncValue = ref.watch(locationProvider);
    return locationAsyncValue.when(
      loading: () => null,
      error: (error, stack) => null,
      data: (locationData) {
        if (locationData == null|| locationData.latitude == null || locationData.longitude == null || locationData.latitude!.isNaN ) {
          return null;
        }
    
  return LatLng(locationData.latitude!, locationData.longitude!);

});});