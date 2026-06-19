import 'package:flutter/material.dart';
import 'package:hop_navi/pages/map_page/widgets/map_widget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('マップページ')),
      body: Center(
        child: Column(
          mainAxisAlignment: .spaceAround,
          children: [
            Expanded(       
              child:MapWidget(),
            ),
          ],
        ),
      ),
    );
  }
}