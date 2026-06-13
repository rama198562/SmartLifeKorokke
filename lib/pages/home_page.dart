import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // context.pushを使うために必要

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム画面')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 詳細画面へ遷移
            context.push('/details');
          },
          child: const Text('詳細画面へ進む'),
        ),
      ),
    );
  }
}