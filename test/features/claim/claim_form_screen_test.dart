import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/auth/domain/auth_user.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/claim/presentation/claim_form_screen.dart';
import 'package:campus_lost/features/claim/presentation/providers/claims_provider.dart';

void main() {
  testWidgets('claim form is available for a found item with held status', (
    tester,
  ) async {
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
        child: const MaterialApp(home: ClaimFormScreen(itemId: 'item-3')),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Scientific calculator'), findsOneWidget);
    expect(find.text('Submit Claim'), findsOneWidget);
    expect(
      find.text('This item is no longer available to claim.'),
      findsNothing,
    );
  });

  testWidgets('shows message when user has already claimed the item', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialAuthUserProvider.overrideWith(
            (ref) => const AuthUser(
              id: 'user-1',
              fullName: 'Selam Kebede',
              email: 'selam@test.com',
            ),
          ),
        ],
        child: const MaterialApp(home: ClaimFormScreen(itemId: 'item-2')),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('You have already submitted a claim for this item.'),
      findsOneWidget,
    );
  });
  testWidgets('shows unavailable message for a returned item', (tester) async {
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
        child: const MaterialApp(home: ClaimFormScreen(itemId: 'item-5')),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('This item is no longer available to claim.'),
      findsOneWidget,
    );
  });
  testWidgets('shows validation message when claim form is empty', (
    tester,
  ) async {
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
        child: const MaterialApp(home: ClaimFormScreen(itemId: 'item-3')),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('Submit Claim'));
    await tester.pump();

    expect(find.text('Please explain why this item is yours.'), findsOneWidget);
  });

  testWidgets('successfully submits a claim', (tester) async {
    final container = ProviderContainer(
      overrides: [
        initialAuthUserProvider.overrideWith(
          (ref) => const AuthUser(
            id: 'user-2',
            fullName: 'Test Student',
            email: 'student@test.com',
          ),
        ),
      ],
    );

    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ClaimFormScreen(itemId: 'item-3')),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField),
      'The calculator has my name written on it.',
    );

    await tester.tap(find.text('Submit Claim'));
    await tester.pumpAndSettle();

    final claims = container.read(claimsProvider).value ?? [];

    expect(
      claims.any(
        (claim) =>
            claim.itemId == 'item-3' &&
            claim.claimantId == 'user-2' &&
            claim.message == 'The calculator has my name written on it.',
      ),
      isTrue,
    );
  });
}
