import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';
import 'package:campus_lost/features/claim/presentation/providers/claims_provider.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/presentation/providers/items_provider.dart';
import 'package:campus_lost/features/review_claims/presentation/providers/review_claims_providers.dart';
import 'package:campus_lost/features/review_claims/presentation/widgets/claim_review_card.dart';

class ReviewClaimsScreen extends ConsumerWidget {
  const ReviewClaimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    if (user == null || !user.isCustodian) {
      return Scaffold(
        appBar: AppBar(title: const Text('Review Claims')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Only custodians can review claims.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final filter = ref.watch(claimFilterProvider);
    final claimsAsync = ref.watch(claimsProvider);
    final itemsAsync = ref.watch(itemsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Review Claims')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SegmentedButton<ClaimStatus>(
              segments: const [
                ButtonSegment(
                  value: ClaimStatus.pending,
                  label: Text('Pending'),
                ),
                ButtonSegment(
                  value: ClaimStatus.approved,
                  label: Text('Approved'),
                ),
                ButtonSegment(
                  value: ClaimStatus.rejected,
                  label: Text('Rejected'),
                ),
              ],
              selected: {filter},
              onSelectionChanged: (selection) => ref
                  .read(claimFilterProvider.notifier)
                  .select(selection.first),
            ),
          ),
          Expanded(
            child: claimsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  const Center(child: Text('Could not load claims.')),
              data: (claims) => itemsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) =>
                    const Center(child: Text('Could not load items.')),
                data: (items) => _ClaimList(
                  claims: claims.where((c) => c.status == filter).toList(),
                  items: items,
                  filter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClaimList extends StatelessWidget {
  const _ClaimList({
    required this.claims,
    required this.items,
    required this.filter,
  });

  final List<ClaimRequest> claims;
  final List<ItemReport> items;
  final ClaimStatus filter;

  @override
  Widget build(BuildContext context) {
    if (claims.isEmpty) {
      return Center(child: Text('No ${filter.name} claims.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: claims.length,
      itemBuilder: (context, index) {
        final claim = claims[index];
        ItemReport? foundItem;
        for (final item in items) {
          if (item.id == claim.itemId) {
            foundItem = item;
            break;
          }
        }
        return ClaimReviewCard(claim: claim, item: foundItem);
      },
    );
  }
}
