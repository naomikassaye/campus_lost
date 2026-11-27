import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/core/theme/theme_mode_provider.dart';
import 'package:campus_lost/features/auth/domain/auth_repository.dart';
import 'package:campus_lost/features/auth/domain/auth_user.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/profile/data/in_memory_cache_maintenance.dart';
import 'package:campus_lost/features/profile/domain/cache_maintenance.dart';
import 'package:campus_lost/features/profile/presentation/profile_screen.dart';
import 'package:campus_lost/features/profile/presentation/providers/profile_providers.dart';

const _student = AuthUser(
  id: 'user-1',
  fullName: 'Selam Kebede',
  email: 'student@aau.edu.et',
);

const _custodian = AuthUser(
  id: 'custodian-1',
  fullName: 'Kebede Abebe',
  email: 'custodian@aau.edu.et',
  isCustodian: true,
);

class _FakeAuthRepository implements AuthRepository {
  int signOutCalls = 0;

  @override
  Future<AuthUser> signIn({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    signOutCalls++;
  }
}

Future<void> _pump(
  WidgetTester tester, {
  AuthUser user = _student,
  CacheMaintenance? cache,
  _FakeAuthRepository? auth,
}) async {
  final router = GoRouter(
    initialLocation: '/profile',
    routes: [
      GoRoute(path: '/profile', builder: (_, _) => const ProfileScreen()),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, _) => const Scaffold(body: Text('LOGIN PAGE')),
      ),
      GoRoute(
        path: AppRoutes.reviewClaims,
        builder: (_, _) => const Scaffold(body: Text('REVIEW PAGE')),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        initialAuthUserProvider.overrideWithValue(user),
        if (cache != null) cacheMaintenanceProvider.overrideWithValue(cache),
        if (auth != null) authRepositoryProvider.overrideWithValue(auth),
      ],
      retry: (retryCount, error) => null,
      child: Consumer(
        builder: (context, ref, _) {
          return MaterialApp.router(
            themeMode: ref.watch(themeModeProvider),
            routerConfig: router,
          );
        },
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the signed-in user and role', (tester) async {
    await _pump(tester);

    expect(find.text('Selam Kebede'), findsOneWidget);
    expect(find.text('student@aau.edu.et'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
    expect(find.text('Review claims'), findsNothing);
  });

  testWidgets('custodian sees the review claims shortcut', (tester) async {
    await _pump(tester, user: _custodian);

    await tester.tap(find.text('Review claims'));
    await tester.pumpAndSettle();

    expect(find.text('REVIEW PAGE'), findsOneWidget);
  });

  testWidgets('theme selector updates the app theme mode', (tester) async {
    await _pump(tester);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MaterialApp && widget.themeMode == ThemeMode.dark,
      ),
      findsOneWidget,
    );
  });

  testWidgets('clear cache asks for confirmation, then actually clears data', (
    tester,
  ) async {
    final cache = InMemoryCacheMaintenance();
    await cache.save('draft', 'Sample draft');
    expect(await cache.read('draft'), isNotNull);

    await _pump(tester, cache: cache);

    await tester.tap(find.text('Clear cached data'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();

    expect(await cache.read('draft'), isNull);
    expect(find.text('Cached data cleared.'), findsOneWidget);
  });

  testWidgets('cancelling confirmation does not clear the cache', (
    tester,
  ) async {
    final cache = InMemoryCacheMaintenance();
    await cache.save('draft', 'Sample draft');

    await _pump(tester, cache: cache);

    await tester.tap(find.text('Clear cached data'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(await cache.read('draft'), 'Sample draft');
  });

  testWidgets('sign out signs out and goes to login', (tester) async {
    final auth = _FakeAuthRepository();
    await _pump(tester, auth: auth);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(auth.signOutCalls, 1);
    expect(find.text('LOGIN PAGE'), findsOneWidget);
  });
}
