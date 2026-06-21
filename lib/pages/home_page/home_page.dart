import 'package:flutter/material.dart';
import 'package:hop_navi/pages/home_page/widgets/category_grid.dart';
import 'package:hop_navi/pages/home_page/widgets/distance_slider.dart';
import 'package:hop_navi/pages/home_page/widgets/route_generate_button.dart'; // context.pushを使うために必要

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ルート設定',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
          
              CategoryGrid(),
              SizedBox(height: 24),  
              DistanceSlider(),
              SizedBox(height: 24),  
              RouteGenerateButton(),
          
              // SizedBox(height: 24),            
              // ElevatedButton(
          
              //   onPressed: () {
              //     // マップ画面へ遷移
              //     context.push('/details');
              //   },
              //   child: const Text('マップに移行'),  //マップ画面を確認するためのテスト
              // ),
            ],
          ),
        ),
      ),
    );
  }
}