import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hop_navi/models/route_model.dart'; // SpotModelを使う想定

class OverpassService {
  Future<List<SpotModel>> getNearbySpots(double lat, double lon, double radiusMeters, String category) async {
    // OSMのタグに変換
    String tag = '';
    if (category == '公園' || category == 'park') tag = 'nw["leisure"~"park|playground"]';
    if (category == 'スーパー' || category == 'supermarket' || category == '平和堂') {

      tag = 'nw["shop"="supermarket"]';
    }
    if (category == '病院' || category == 'hospital') tag = 'nw["amenity"="hospital"]';
    if (category == '小学校' || category == 'primary_school') tag = 'nw["amenity"="school"]';
    if (category == '幼稚園' || category == 'kindergarten') tag = 'nw["amenity"="kindergarten"]';
    
    if (tag.isEmpty) {
      print('未定義のカテゴリー: $category');
      return [];
    }

    final query = '''
      [out:json][timeout:15];
      (
        $tag(around:$radiusMeters, $lat, $lon);
      );
      out center;
    ''';
    final url = Uri.parse('https://overpass.kumi.systems/api/interpreter');
    // final url = Uri.parse('https://lz4.overpass-api.de/api/interpreter');

    try {
      final response = await http.post(
        url, 
        headers: {'User-Agent': 'HopNaviApp/1.0'},
        body: query
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<SpotModel> spots = [];

        for (var element in data['elements']) {
          final lat = element['lat'] ?? element['center']['lat'];
          final lon = element['lon'] ?? element['center']['lon'];
          
          if (element['tags'] != null) {
            final tags = element['tags'];
            String? bestName = tags['official_name'] ?? tags['name:ja'] ?? tags['name'];
            final branch = tags['branch'];
            
            if (bestName != null) {
              String displayName = bestName;
              if (branch != null && !displayName.contains(branch)) {
                displayName = '$displayName $branch';
              }

              if (category == '平和堂') {
                if (!bestName.contains('平和堂') && !bestName.contains('フレンドマート') && !bestName.contains('アル・プラザ')) {
                  continue;
                }

              }
            
            spots.add(SpotModel(
              name: displayName,
              type: category,
              latitude: lat,
              longitude: lon,
            ));
            }
          }
        }
        return spots;
      } else {
        print('Overpass API エラー: ステータスコード ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      print('Overpass API エラー: $e');
    }
    return [];
  }
}
