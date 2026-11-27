import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/auth/domain/auth_user.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/my_activity/presentation/my_activity_screen.dart';

void main() {
  testWidgets('shows the signed-in student reports and claims', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserProvider.overrideWithValue(
            const AuthUser(
              id: 'user-1',
              fullName: 'Selam Kebede',
              email: 'student@aau.edu.et',
            ),
          ),
        ],
        child: const MaterialApp(home: MyActivityScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Black wallet'), findsOneWidget);
    expect(find.text('Phone charger'), findsOneWidget);
    expect(find.text('Set of keys'), findsOneWidget);
    expect(find.text('Scientific calculator'), findsNothing);
  });

  testWidgets('asks a signed-out user to sign in', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [currentUserProvider.overrideWithValue(null)],
        child: const MaterialApp(home: MyActivityScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Please sign in to see your activity.'), findsOneWidget);
  });
}
