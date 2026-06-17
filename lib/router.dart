import 'package:go_router/go_router.dart';
import 'pages/home_page/home_page.dart';
import 'pages/map_page/map_page.dart';

final GoRouter myRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsScreen(),
    ),
  ],
);