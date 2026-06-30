// import 'package:flutter/material.dart';
// import 'package:hop_navi/pages/map_page/widgets/map_widget.dart';

// class DetailsScreen extends StatelessWidget {
//   const DetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('マップページ')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: .spaceAround,
//           children: [
//             Expanded(       
//               child:MapWidget(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:hop_navi/pages/map_page/widgets/map_widget.dart';
// import 'package:hop_navi/models/route_model.dart'; // 👈 追加: RouteModelをインポート

// class DetailsScreen extends StatelessWidget {
//   final RouteModel routeModel; // 👈 追加: 前の画面から受け取るデータ

//   // 👈 修正: required this.routeModel を追加して必須にする
//   const DetailsScreen({super.key, required this.routeModel});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // 👈 修正: タイトルをGeminiが考えた「ルート名」にする！
//       appBar: AppBar(title: Text(routeModel.routeName)), 
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Expanded(       
//               child: MapWidget(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hop_navi/pages/map_page/widgets/map_widget.dart';
import 'package:hop_navi/models/route_model.dart'; // RouteModelのインポート
import 'package:hop_navi/pages/map_page/widgets/waypoints_bottom_sheet.dart';

class DetailsScreen extends StatelessWidget {
  final RouteModel? routeModel; 

  const DetailsScreen({super.key, this.routeModel});

  void _showWaypoints(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return WaypointsBottomSheet(routeModel: routeModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeName = routeModel?.routeName ?? 'お散歩マップ';
    var description = routeModel?.description ?? '';

    if (routeModel != null && routeModel!.distance > 0) {
      final distanceKm = (routeModel!.distance / 1000).toStringAsFixed(1);
      description = '総距離: 約$distanceKm km\n$description';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ルート案内'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: '経由地を確認',
            onPressed: () => _showWaypoints(context),
          ),
        ],
      ), 
      body: Column(
        children: [
          // タイトルと説明文をしっかり見せるためのエリア
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routeName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(       
            child: MapWidget(routeModel: routeModel),
          ),
        ],
      ),
    );
  }
}
