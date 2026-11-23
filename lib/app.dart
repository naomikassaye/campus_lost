import 'package:flutter/material.dart';
import 'package:campus_lost/core/router/app_router.dart';
import 'package:campus_lost/core/theme/app_theme.dart';

class CampusLostApp extends StatelessWidget {
  const CampusLostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CampusLost',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
