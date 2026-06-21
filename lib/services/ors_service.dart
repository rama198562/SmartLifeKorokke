import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hop_navi/models/route_model.dart';

class OrsApiService {
  // ORSから車椅子ルートを取得
  static Future<List<LatLng>> getStrollerRoute({
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

    final apiKey = dotenv.env['ORS_API_KEY'] ?? '';
    if (apiKey.isEmpty) return [];

    final url = Uri.parse('https://api.openrouteservice.org/v2/directions/wheelchair/geojson');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "coordinates": coordinates,
          "options": {
            "avoid_features": ["steps"],
          }
          }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> routeCoords = data['features'][0]['geometry']['coordinates'];

        return routeCoords.map((coord) => LatLng(coord[1], coord[0])).toList();
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