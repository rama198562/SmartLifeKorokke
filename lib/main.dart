import 'package:flutter/material.dart';
import 'package:hop_navi/theme/theme.dart';
import 'package:hop_navi/theme/util.dart';
import 'router.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Zen Maru Gothic", "Zen Maru Gothic");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      routerConfig: myRouter,
      title: 'Hackathon App',
      theme: theme.light(),
      themeMode: .light,
    );
  }
}