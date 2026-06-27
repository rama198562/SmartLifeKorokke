import 'package:flutter/material.dart';
import 'package:hop_navi/models/route_model.dart';

class WaypointsBottomSheet extends StatelessWidget {
  final RouteModel? routeModel;

  const WaypointsBottomSheet({super.key, required this.routeModel});

  @override
  Widget build(BuildContext context) {
    final spots = routeModel?.spots ?? [];
    if (spots.isEmpty) {
      return const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            '経由地の情報はありません。',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '経由地一覧',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: spots.length,
              itemBuilder: (context, index) {
                final spot = spots[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(spot.name),
                  subtitle: Text('タイプ: ${spot.type}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
