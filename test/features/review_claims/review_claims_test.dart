import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/auth/domain/auth_user.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/claim/domain/claim_repository.dart';
import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';
import 'package:campus_lost/features/claim/presentation/providers/claims_provider.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';
import 'package:campus_lost/features/review_claims/domain/claim_rules.dart';
import 'package:campus_lost/features/review_claims/presentation/providers/review_claims_providers.dart';
import 'package:campus_lost/features/review_claims/presentation/review_claims_screen.dart';

ItemReport _item(ItemStatus status) => ItemReport(
  id: 'item-x',
  type: ReportType.found,
  title: 'Keys',
  description: 'Three keys on a ring.',
  category: ItemCategory.keys,
  location: '5 Kilo',
  reporterId: 'custodian-1',
  createdAt: DateTime(2026, 11, 25),
  status: status,
);

ClaimRequest _claim(ClaimStatus status) => ClaimRequest(
  id: 'claim-x',
  itemId: 'item-x',
  claimantId: 'user-1',
  claimantName: 'Selam Kebede',
  message: 'Silver tag with my initials.',
  status: status,
  createdAt: DateTime(2026, 11, 25),
);

class _FailingClaimRepository implements ClaimRepository {
  @override
  Future<List<ClaimRequest>> getAll() async => [];
  @override
  Future<List<ClaimRequest>> getForItem(String itemId) async => [];
  @override
  Future<List<ClaimRequest>> getForUser(String userId) async => [];
  @override
  Future<ClaimRequest> add(ClaimRequest claim) async =>
      throw StateError('boom');
  @override
  Future<ClaimRequest> updateStatus(String id, ClaimStatus status) async =>
      throw StateError('boom');
}

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

void main() {
  test('ClaimRules canApprove works', () {
    expect(ClaimRules.canApprove(_item(ItemStatus.open)), isTrue);
    expect(ClaimRules.canApprove(_item(ItemStatus.claimed)), isFalse);
  });

  test('ReviewActionsNotifier handles failure safely', () async {
    final container = ProviderContainer.test(
      overrides: [
        claimRepositoryProvider.overrideWithValue(_FailingClaimRepository()),
      ],
    );

    final ok = await container
        .read(reviewActionsProvider.notifier)
        .approve(_claim(ClaimStatus.pending));

    expect(ok, isFalse);
    expect(container.read(reviewActionsProvider), isFalse);
  });

  testWidgets('ReviewClaimsScreen restricts students and handles workflow', (
    tester,
  ) async {
    // 1. Student view
    await tester.pumpWidget(
      ProviderScope(
        overrides: [initialAuthUserProvider.overrideWithValue(_student)],
        child: const MaterialApp(home: ReviewClaimsScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Only custodians can review claims.'), findsOneWidget);

    // 2. Custodian workflow (Approve + Mark Returned)
    await tester.pumpWidget(
      ProviderScope(
        overrides: [initialAuthUserProvider.overrideWithValue(_custodian)],
        retry: (retryCount, error) => null,
        child: const MaterialApp(home: ReviewClaimsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('approve-claim-1')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Approved'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('return-claim-1')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('return-claim-1')), findsNothing);
  });
}
