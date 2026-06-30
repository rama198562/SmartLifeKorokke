// lib/services/geocoding_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  Future<Map<String, double>?> getCoordinates(String placeName) async {

    final query = Uri.encodeComponent('$placeName 滋賀県草津市');
    
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1');

    try {
      final response = await http.get(
        url,
        headers: {

          'User-Agent': 'HopNaviApp/1.0', 
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        if (data.isNotEmpty) {
          // 取得できた緯度経度をdouble型にして返す
          return {
            'latitude': double.parse(data[0]['lat'].toString()),
            'longitude': double.parse(data[0]['lon'].toString()),
          };
        }
      }
    } catch (e) {
      print('ジオコーディング通信エラー: $e');
    }
    return null; // 見つからなかった場合
  }
}