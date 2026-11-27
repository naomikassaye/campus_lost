import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';
import 'package:campus_lost/features/claim/presentation/providers/claims_provider.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';
import 'package:campus_lost/features/feed/presentation/providers/items_provider.dart';

class ClaimFilterNotifier extends Notifier<ClaimStatus> {
  @override
  ClaimStatus build() => ClaimStatus.pending;

  void select(ClaimStatus status) => state = status;
}

final claimFilterProvider = NotifierProvider<ClaimFilterNotifier, ClaimStatus>(
  ClaimFilterNotifier.new,
);

class ReviewActionsNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<bool> approve(ClaimRequest claim) async {
    if (state) return false;
    state = true;
    try {
      final others = await ref
          .read(claimRepositoryProvider)
          .getForItem(claim.itemId);
      for (final other in others) {
        if (other.id != claim.id && other.status == ClaimStatus.pending) {
          await ref
              .read(claimsProvider.notifier)
              .updateStatus(other.id, ClaimStatus.rejected);
        }
      }
      await ref
          .read(claimsProvider.notifier)
          .updateStatus(claim.id, ClaimStatus.approved);
      await ref
          .read(itemsProvider.notifier)
          .updateStatus(claim.itemId, ItemStatus.claimed);
      state = false;
      return true;
    } catch (_) {
      state = false;
      return false;
    }
  }

  Future<bool> reject(ClaimRequest claim) async {
    if (state) return false;
    state = true;
    try {
      await ref
          .read(claimsProvider.notifier)
          .updateStatus(claim.id, ClaimStatus.rejected);
      state = false;
      return true;
    } catch (_) {
      state = false;
      return false;
    }
  }

  Future<bool> markReturned(String itemId) async {
    if (state) return false;
    state = true;
    try {
      await ref
          .read(itemsProvider.notifier)
          .updateStatus(itemId, ItemStatus.returned);
      state = false;
      return true;
    } catch (_) {
      state = false;
      return false;
    }
  }
}

final reviewActionsProvider = NotifierProvider<ReviewActionsNotifier, bool>(
  ReviewActionsNotifier.new,
);
