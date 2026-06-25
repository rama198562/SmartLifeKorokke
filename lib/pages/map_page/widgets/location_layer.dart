// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class LocationLayer extends StatelessWidget {
//   const LocationLayer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MarkerLayer(
//       markers: [
//         Marker(
//             width: 30.0,
//             height: 30.0,
//             point: LatLng(35.025438, 135.958355),   //仮座標
//             child: Icon(
//               Icons.location_on,
//               color: Theme.of(context).colorScheme.secondary,

//               size: 50,
//             ),
//           rotate: true,
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hop_navi/widgets/current_location.dart';
import 'package:latlong2/latlong.dart';
import 'package:hop_navi/models/route_model.dart'; // 👈 RouteModelをインポート

class LocationLayer extends StatelessWidget {
  final RouteModel? routeModel; // 👈 データを受け取る

  // const LocationLayer({super.key, this.routeModel});
  final LatLng currentLocation;

  const LocationLayer({
    super.key, 
    required this.currentLocation,
    this.routeModel,
  });
  // const LocationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    // 常に表示するスタート地点（アル・プラザ草津）のマーカー
    List<Marker> markers = [
      // Marker(
      //   width: 40.0,
      //   height: 40.0,
      //   point: const LatLng(35.025438, 135.958355),
      //   child: const Icon(Icons.home, color: Colors.blue, size: 40),
      // ),
      currentLocationMarker(context, currentLocation),
    ];

    // 💡 Geminiが考えたスポットの数だけマーカーを追加する！
    if (routeModel != null && routeModel!.spots.isNotEmpty) {
      for (var spot in routeModel!.spots) {
        markers.add(
          Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(spot.latitude, spot.longitude),
            child: Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.primary,
              size: 50,
            ),
          rotate: true,
        ),
        
        
        
        
    );
    
  }}
    return MarkerLayer(
          markers: markers,
        );
}}