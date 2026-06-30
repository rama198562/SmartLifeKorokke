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
import 'package:hop_navi/models/route_model.dart';

class LocationLayer extends StatelessWidget {
  final RouteModel? routeModel; //  データを受け取る

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
      Marker(
        width: 40.0,
        height: 40.0,
        point: const LatLng(35.025438, 135.958355),
        child: const Icon(Icons.home, color: Colors.blue, size: 40),
      ),
      currentLocationMarker(context, currentLocation),
    ];

    // スポットの数だけマーカーを追加
    if (routeModel != null && routeModel!.spots.isNotEmpty) {
      for (var spot in routeModel!.spots) {
        markers.add(
          Marker(
            width: 150.0, // テキストが入るように広げる
            height: 80.0,
            point: LatLng(spot.latitude, spot.longitude),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(spot.name),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('種類: ${spot.type}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('閉じる'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9), 
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                    ),
                    child: Text(
                      spot.name,
                      style: TextStyle(
                        fontSize: 12, 
                        fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimary, 
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    
    return MarkerLayer(
      markers: markers,
    );
  }
}