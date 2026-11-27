import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_lost/app.dart';
import 'package:campus_lost/core/router/app_router.dart';
import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/features/auth/domain/auth_user.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';

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

Future<GoRouter> _pumpApp(WidgetTester tester, {AuthUser? user}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [currentUserProvider.overrideWithValue(user)],
      child: const CampusLostApp(),
    ),
  );
  await tester.pumpAndSettle();

  final container = ProviderScope.containerOf(
    tester.element(find.byType(MaterialApp)),
  );
  return container.read(routerProvider);
}

String _location(GoRouter router) =>
    router.routerDelegate.currentConfiguration.uri.path;

void main() {
  group('router redirect', () {
    testWidgets('a signed-out user is sent to login', (tester) async {
      final router = await _pumpApp(tester);

      router.go(AppRoutes.reviewClaims);
      await tester.pumpAndSettle();

      expect(_location(router), AppRoutes.login);
    });

    testWidgets('a student cannot open /review-claims', (tester) async {
      final router = await _pumpApp(tester, user: _student);
      expect(_location(router), AppRoutes.feed);

      router.go(AppRoutes.reviewClaims);
      await tester.pumpAndSettle();

      expect(_location(router), AppRoutes.feed);
    });

    testWidgets('a custodian can open /review-claims', (tester) async {
      final router = await _pumpApp(tester, user: _custodian);
      expect(_location(router), AppRoutes.feed);

      router.go(AppRoutes.reviewClaims);
      await tester.pumpAndSettle();

      expect(_location(router), AppRoutes.reviewClaims);
    });
  });
}
