import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hop_navi/pages/map_page/widgets/location_layer.dart';
import 'package:hop_navi/pages/map_page/widgets/maproute_layer.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        // アル・プラザ草津(仮)
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
        LocationLayer(),
        MaprouteLayer(),

      ],
    );
  }
}