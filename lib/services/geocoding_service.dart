// lib/services/geocoding_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  Future<Map<String, double>?> getCoordinates(String placeName) async {
    // 💡 工夫ポイント: 単に「カフェ」と検索すると世界中から探してしまうので、
    // 検索語の後ろに「滋賀県草津市」などエリアを固定で追加して精度を上げます！
    final query = Uri.encodeComponent('$placeName 滋賀県草津市');
    
    // limit=1 で一番関連度の高い1件だけを取得します
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1');

    try {
      final response = await http.get(
        url,
        headers: {
          // 🚨【超重要】Nominatimの規約で「User-Agent」の指定が必須です！
          // これがないとアクセスブロックされるので、アプリ名を入れます。
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