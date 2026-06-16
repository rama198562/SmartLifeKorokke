import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hop_navi/widgets/category_grid.dart'; // context.pushを使うために必要

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム画面')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
          
              CategoryGrid(),
          
              SizedBox(height: 24),            
              ElevatedButton(
          
                onPressed: () {
                  // 詳細画面へ遷移
                  context.push('/details');
                },
                child: const Text('ルートを生成する'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}