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

    return Scaffold(
      appBar: AppBar(
        title: Text(routeName),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: '経由地を確認',
            onPressed: () => _showWaypoints(context),
          ),
        ],
      ), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(       
              child: MapWidget(routeModel: routeModel),
            ),
          ],
        ),
      ),
    );
  }
}
