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

class DetailsScreen extends StatelessWidget {
  // 👈 修正: ?（ぬるぽ許可）をつけて、送られてこなくても大丈夫にする
  final RouteModel? routeModel; 

  // 👈 修正: 必須（required）を外し、デフォルトで null にする
  const DetailsScreen({super.key, this.routeModel});

  @override
  Widget build(BuildContext context) {
    // 👈 追加: もし routeModel が空っぽ（ルーター経由で開かれた時など）なら、仮のタイトルを表示する
    final routeName = routeModel?.routeName ?? 'お散歩マップ';

    return Scaffold(
      appBar: AppBar(
        title: Text(routeName), // 👈 決定したタイトルを表示
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
