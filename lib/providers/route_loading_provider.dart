// lib/providers/route_loading_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/services/gemini_service.dart';
import 'package:hop_navi/services/geocoding_service.dart';
import 'package:hop_navi/models/route_model.dart';
import 'package:hop_navi/services/ors_service.dart';
import 'package:latlong2/latlong.dart';

final routeLoadingProvider = NotifierProvider.autoDispose<RouteLoadingNotifier, bool>(RouteLoadingNotifier.new);

class RouteLoadingNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  Future<RouteModel?> generateAndGetRoute(List<String> categories, double distance, LatLng currentLocation, String extraText) async {
    state = true;

    try {
      final geminiService = GeminiService();
      final geocodingService = GeocodingService();

      // 1. Geminiにスポット名だけを考えさせる
      final routeData = await geminiService.generateRouteFromGemini(categories, distance, currentLocation, extraText);
      if (routeData == null) return null;

      List<SpotModel> validSpots = [];

      // 2. 提案されたスポットを1つずつジオコーディングする
      for (var spot in routeData.spots) {
        final coords = await geocodingService.getCoordinates(spot.name);
        
        if (coords != null) {
          validSpots.add(
            SpotModel(
              name: spot.name,
              type: spot.type,
              latitude: coords['latitude']!,
              longitude: coords['longitude']!,
            )
          );
        }
        await Future.delayed(const Duration(seconds: 1)); // 1秒待機（Nominatim対策）
      }

      // 3. 座標付きのスポットリストを使って仮のRouteModelを作る
      final tempRoute = RouteModel(
        routeName: routeData.routeName,
        description: routeData.description,
        spots: validSpots,
      );

      // 4. ORSから実際のルート座標と総距離を取得する
      final orsResult = await OrsApiService.getStrollerRoute(
        currentLocation: currentLocation,
        routeModel: tempRoute,
      );

      return RouteModel(
        routeName: tempRoute.routeName,
        description: tempRoute.description,
        spots: tempRoute.spots,
        distance: orsResult.distance,
        segments: orsResult.segments,
      );

    } catch (e) {
      print('ルート生成エラー: $e');
      return null;
    } finally {
      state = false;
    }
  }
}
