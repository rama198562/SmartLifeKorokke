// class RouteSpot {
//   final String name;
//   final String type;

//   RouteSpot({
//     required this.name,
//     required this.type,
//   });

//   factory RouteSpot.fromJson(Map<String, dynamic> json) {
//     return RouteSpot(
//       name: json['name'],
//       type: json['type'],
//     );
//   }
// }

// class RouteModel {
//   final String routeName;
//   final String description;
//   final List<RouteSpot> spots;

//   RouteModel({
//     required this.routeName,
//     required this.description,
//     required this.spots,
//   });

//   factory RouteModel.fromJson(Map<String, dynamic> json) {
//     return RouteModel(
//       routeName: json['routeName'],
//       description: json['description'],
//       spots: (json['spots'] as List)
//           .map((e) => RouteSpot.fromJson(e))
//           .toList(),
//     );
//   }
// }

class RouteModel {
  final String routeName;
  final String description;
  final List<SpotModel> spots;

  RouteModel({
    required this.routeName,
    required this.description,
    required this.spots,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    var list = json['spots'] as List? ?? [];
    List<SpotModel> spotsList = list.map((i) => SpotModel.fromJson(i)).toList();

    return RouteModel(
      routeName: json['routeName'] ?? 'お散歩ルート',
      description: json['description'] ?? '',
      spots: spotsList,
    );
  }
}

class SpotModel {
  final String name;
  final String type;
  final double latitude; // 💡 Geminiが予測した緯度を受け取る
  final double longitude; // 💡 Geminiが予測した経度を受け取る

  SpotModel({
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  factory SpotModel.fromJson(Map<String, dynamic> json) {
    return SpotModel(
      name: json['name'] ?? '名称不明スポット',
      type: json['type'] ?? 'unknown',
      // 💡 int（整数）で返ってきた場合でもエラーにならないよう .toDouble() を付与
      latitude: (json['latitude'] ?? 35.025438).toDouble(),
      longitude: (json['longitude'] ?? 135.958355).toDouble(),
    );
  }
}