import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const PlaceholderPage(title: 'Login / Register'),
    ),
    GoRoute(
      path: '/feed',
      builder: (context, state) => const PlaceholderPage(title: 'Feed'),
    ),
    GoRoute(
      path: '/items/:itemId',
      builder: (context, state) => PlaceholderPage(
        title: 'Item Details: ${state.pathParameters['itemId']}',
      ),
    ),
    GoRoute(
      path: '/report',
      builder: (context, state) => const PlaceholderPage(title: 'Report Item'),
    ),
    GoRoute(
      path: '/items/:itemId/claim',
      builder: (context, state) => PlaceholderPage(
        title: 'Claim Item: ${state.pathParameters['itemId']}',
      ),
    ),
    GoRoute(
      path: '/activity',
      builder: (context, state) => const PlaceholderPage(title: 'My Activity'),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const PlaceholderPage(title: 'Profile & Settings'),
    ),
    GoRoute(
      path: '/review-claims',
      builder: (context, state) => const PlaceholderPage(title: 'Review Claims'),
    ),
  ],
);

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
