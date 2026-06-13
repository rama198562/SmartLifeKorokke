import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('マップページ')),
      body: Center(
        child: Column(
          mainAxisAlignment: .spaceAround,
          children: [
            Container(
              width: 300,
              height: 600,
              child:FlutterMap(
                    options: const MapOptions(
                      // アル・プラザ草津
                      initialCenter: LatLng(35.025438, 135.958355),
                      //初期ズーム
                      initialZoom: 18.0,
                    ),
                    children: [
                      TileLayer(  //openstreetmap
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'korokke.osanpo',
                        tileProvider: NetworkTileProvider(
                          headers: {
                            'Referer': 'https://github.com/rama198562/SmartLifeKorokke',
                          },
                        ),
                      ),
                      const MarkerLayer(
                        markers: [
                          Marker(
                              width: 30.0,
                              height: 30.0,
                              point: LatLng(35.025438, 135.958355), 
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,

                                size: 50,
                              ),
                              rotate: true,
                          ),
                        ],
                    ),
                    PolylineLayer(
                      polylines: [
                          Polyline(
                            points: [
                                const LatLng(35.025634, 135.957575),
                                const LatLng(35.025042, 135.957082),
                                const LatLng(35.025437, 135.956315),
                                const LatLng(35.024083, 135.955220),
                            ],
                            strokeWidth: 3.0,
                            color: Colors.black,
                          ),
                      ],
                    ),
                  ],
                ),

            ),

          ],
        ),
      ),
    );
  }
}