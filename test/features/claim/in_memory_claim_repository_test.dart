import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/claim/data/in_memory_claim_repository.dart';
import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';

void main() {
  late InMemoryClaimRepository repo;

  setUp(() => repo = InMemoryClaimRepository());

  test('add inserts a new pending claim first', () async {
    final saved = await repo.add(
      ClaimRequest(
        id: '',
        itemId: 'item-1',
        claimantId: 'user-4',
        claimantName: 'Hana Tesfaye',
        message: 'My name is written inside the cover.',
        createdAt: DateTime(2026, 11, 25),
      ),
    );

    final all = await repo.getAll();
    expect(all.first.id, saved.id);
    expect(saved.status, ClaimStatus.pending);
  });

  test('updateStatus changes the claim status', () async {
    final updated = await repo.updateStatus('claim-1', ClaimStatus.approved);
    expect(updated.status, ClaimStatus.approved);
  });

  test('updateStatus throws for an unknown id', () async {
    expect(
      () => repo.updateStatus('missing', ClaimStatus.approved),
      throwsStateError,
    );
  });

  test('getForItem returns only that item claims', () async {
    final claims = await repo.getForItem('item-2');
    expect(claims, isNotEmpty);
    expect(claims.every((c) => c.itemId == 'item-2'), isTrue);
  });
}
