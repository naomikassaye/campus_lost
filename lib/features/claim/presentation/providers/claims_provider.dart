import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/claim/data/in_memory_claim_repository.dart';
import 'package:campus_lost/features/claim/domain/claim_repository.dart';
import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';

final claimRepositoryProvider = Provider<ClaimRepository>(
  (ref) => InMemoryClaimRepository(),
);

class ClaimsNotifier extends AsyncNotifier<List<ClaimRequest>> {
  @override
  Future<List<ClaimRequest>> build() =>
      ref.watch(claimRepositoryProvider).getAll();

  Future<void> add(ClaimRequest claim) async {
    await ref.read(claimRepositoryProvider).add(claim);
    ref.invalidateSelf();
    await future;
  }

  Future<void> updateStatus(String id, ClaimStatus status) async {
    await ref.read(claimRepositoryProvider).updateStatus(id, status);
    ref.invalidateSelf();
    await future;
  }
}

final claimsProvider =
    AsyncNotifierProvider<ClaimsNotifier, List<ClaimRequest>>(
      ClaimsNotifier.new,
    );
