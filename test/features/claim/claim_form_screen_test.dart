
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/auth/domain/auth_user.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/claim/presentation/claim_form_screen.dart';

void main() {
  testWidgets(
    'claim form is available for a found item with held status',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            initialAuthUserProvider.overrideWith(
              (ref) => const AuthUser(
                id: 'user-2',
                fullName: 'Test Student',
                email: 'student@test.com',
              ),
            ),
          ],
          child: const MaterialApp(
            home: ClaimFormScreen(itemId: 'item-3'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Scientific calculator'), findsOneWidget);
      expect(find.text('Submit Claim'), findsOneWidget);
      expect(
        find.text('This item is no longer available to claim.'),
        findsNothing,
      );
    },
  );
}
