import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hop_navi/theme/theme.dart';
import 'package:hop_navi/theme/util.dart';
import 'router.dart'; 

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),

  );
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