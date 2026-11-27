import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/core/router/app_router.dart';
import 'package:campus_lost/core/theme/app_theme.dart';
import 'package:campus_lost/core/theme/theme_mode_provider.dart';

class CampusLostApp extends ConsumerWidget {
  const CampusLostApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'CampusLost',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ref.watch(themeModeProvider),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
