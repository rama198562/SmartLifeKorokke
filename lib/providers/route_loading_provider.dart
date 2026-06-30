import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/services/gemini_service.dart';
import 'package:hop_navi/models/route_model.dart';
import 'package:hop_navi/services/ors_service.dart';
import 'package:hop_navi/services/overpass_service.dart';
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
      final overpass = OverpassService();
      final gemini = GeminiService();
      List<SpotModel> allFoundSpots = [];


      final double searchRadiusMeters = (distance / 2) * 1000;
      
      for (var category in categories) {
        if (category == '平和堂') continue;
        final spots = await overpass.getNearbySpots(currentLocation.latitude, currentLocation.longitude, searchRadiusMeters, category);
        allFoundSpots.addAll(spots);
        // Overpass APIのアクセス制限帽子
        await Future.delayed(const Duration(seconds: 1));
      }

      // 平和堂追加
      List<SpotModel> heiwadoSpots = [];
      for (int i = 0; i < 3; i++) {
        await Future.delayed(const Duration(seconds: 1));
        heiwadoSpots = await overpass.getNearbySpots(currentLocation.latitude, currentLocation.longitude, distance * 1000, '平和堂');
        if (heiwadoSpots.isNotEmpty) break;
        print('平和堂の取得に失敗したか0件でした。リトライします...($i)');
      }

      SpotModel? nearestHeiwado;
      String heiwadoInstruction = "";
      if (heiwadoSpots.isNotEmpty) {
        // 最寄りの平和堂を特定
        double minDistance = double.infinity;
        final Distance distanceCalc = const Distance();

        for (var spot in heiwadoSpots) {
          final d = distanceCalc.as(LengthUnit.Meter, currentLocation, LatLng(spot.latitude, spot.longitude));
          if (d < minDistance) {
            minDistance = d;
            nearestHeiwado = spot;
          }
        }

        if (nearestHeiwado != null) {
          allFoundSpots.add(nearestHeiwado); // 最寄りの1店舗だけを候補リストに追加する
          heiwadoInstruction = "\n\n【絶対条件】リスト内にある「${nearestHeiwado!.name}」を、お散歩の目的地や経由地として必ずルートに含めてください。";
        }
      }

      if (allFoundSpots.isEmpty) {
        print('エラー: 該当するスポットが見つかりませんでした');
        return null;
      }

      final Distance distanceCalcForPrompt = const Distance();
      List<String> spotsWithDistance = [];
      
      allFoundSpots.sort((a, b) {
        final dA = distanceCalcForPrompt.as(LengthUnit.Meter, currentLocation, LatLng(a.latitude, a.longitude));
        final dB = distanceCalcForPrompt.as(LengthUnit.Meter, currentLocation, LatLng(b.latitude, b.longitude));
        return dA.compareTo(dB);
      });

      for (var s in allFoundSpots) {
        final d = distanceCalcForPrompt.as(LengthUnit.Meter, currentLocation, LatLng(s.latitude, s.longitude));
        spotsWithDistance.add("【${s.type}】${s.name} (現在地から直線で約${d}m)");
      }

      String availableSpotsText = spotsWithDistance.toSet().join('\n');
      
      final geminiResult = await gemini.generateRouteFromList(
        categories: categories,
        distance: distance,
        availableSpotsText: availableSpotsText,
        extraText: extraText,
        heiwadoInstruction: heiwadoInstruction,
      );

      List<SpotModel> finalSpots = [];
      for (var name in geminiResult.selectedSpotNames) {
        try {
          final match = allFoundSpots.firstWhere((s) => s.name == name);
          finalSpots.add(match);
        } catch (e) {
          print('Geminiが選んだスポット($name)がリストに存在しませんでした。スキップします。');
        }
      }

      if (nearestHeiwado != null) {
        final hasHeiwado = finalSpots.any((s) => s.name == nearestHeiwado!.name);
        if (!hasHeiwado) {
          print('Geminiが平和堂を含めなかったため、ルートに追加します: ${nearestHeiwado!.name}');
          finalSpots.add(nearestHeiwado!);
        }
      }

      final tempRoute = RouteModel(
        routeName: geminiResult.routeName,
        description: geminiResult.description,
        spots: finalSpots,
      );

      if (finalSpots.isEmpty) {
        print('エラー: 有効なスポットが一つも選ばれませんでした');
        return null;
      }

      // 4. 完成したルート情報を返す（これをORSに渡す）
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
