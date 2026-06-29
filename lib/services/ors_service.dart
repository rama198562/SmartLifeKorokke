import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hop_navi/models/route_model.dart';

class OrsApiService {
  // ORSから車椅子ルートを取得
  static Future<List<List<LatLng>>> getStrollerRoute({
    required LatLng currentLocation,
    RouteModel? routeModel,
  }) async {
    List<List<double>> coordinates = [];

    // スタート地点
    coordinates.add([currentLocation.longitude, currentLocation.latitude]);

    // 経由地
    if (routeModel != null && routeModel.spots.isNotEmpty) {
      for (var spot in routeModel.spots) {
        coordinates.add([spot.longitude, spot.latitude]);
      }
    } else {
      return [];
    }

    // ゴール地点（スタートと同じ現在地に戻る）
    coordinates.add([currentLocation.longitude, currentLocation.latitude]);

    final apiKey = dotenv.env['ORS_API_KEY'] ?? '';
    if (apiKey.isEmpty) return [];
    // 車椅子モード
    // final url = Uri.parse('https://api.openrouteservice.org/v2/directions/wheelchair/geojson');
    // 徒歩モード
    final url = Uri.parse('https://api.openrouteservice.org/v2/directions/foot-walking/geojson');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "coordinates": coordinates,
          }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> routeCoords = data['features'][0]['geometry']['coordinates'];
        final List<dynamic>? wayPointsDynamic = data['features'][0]['properties']['way_points'];
        
        List<int> wayPoints = [0, routeCoords.length - 1];
        if (wayPointsDynamic != null) {
          wayPoints = wayPointsDynamic.map((e) => e as int).toList();
        }

        List<List<LatLng>> segments = [];
        for (int i = 0; i < wayPoints.length - 1; i++) {
          int startIdx = wayPoints[i];
          int endIdx = wayPoints[i + 1];
          // endIdx is inclusive for the segment, so we take up to endIdx + 1
          final segmentCoords = routeCoords.sublist(startIdx, endIdx + 1);
          segments.add(segmentCoords.map((coord) => LatLng(coord[1], coord[0])).toList());
        }

        return segments;
      } else {
        print('ORSエラー: ${response.body}');
        return [];
      }
    } catch (e) {
      print('通信エラー: $e');
      return [];
    }
  }
}