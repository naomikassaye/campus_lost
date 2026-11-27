import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';

/// Business rules for what a custodian may do with a claim.
abstract final class ClaimRules {
  /// A claim can be approved only while the item is still available.
  static bool canApprove(ItemReport? item) {
    if (item == null) return false;
    return item.status == ItemStatus.open || item.status == ItemStatus.held;
  }

  /// An item can be marked returned after its claim was approved.
  static bool canMarkReturned(ClaimRequest claim, ItemReport? item) {
    if (item == null) return false;
    return claim.status == ClaimStatus.approved &&
        item.status == ItemStatus.claimed;
  }
}
