import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/review_claims/domain/claim_rules.dart';
import 'package:campus_lost/features/review_claims/presentation/providers/review_claims_providers.dart';

class ClaimReviewCard extends ConsumerWidget {
  const ClaimReviewCard({required this.claim, required this.item, super.key});

  final ClaimRequest claim;
  final ItemReport? item;

  Future<void> _approve(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final controller = ref.read(reviewActionsProvider.notifier);
    final ok = await controller.approve(claim);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Claim approved.' : 'Could not approve the claim. Try again.',
        ),
      ),
    );
  }

  Future<void> _reject(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final controller = ref.read(reviewActionsProvider.notifier);
    final ok = await controller.reject(claim);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Claim rejected.' : 'Could not reject the claim. Try again.',
        ),
      ),
    );
  }

  Future<void> _markReturned(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final controller = ref.read(reviewActionsProvider.notifier);
    final ok = await controller.markReturned(claim.itemId);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Item marked as returned.' : 'Could not update the item.',
        ),
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isWorking = ref.watch(reviewActionsProvider);
    final canApprove = ClaimRules.canApprove(item);
    final canMarkReturned = ClaimRules.canMarkReturned(claim, item);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item?.title ?? 'Unknown item',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                _StatusChip(status: claim.status),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Claimed by ${claim.claimantName} '
              'on ${_formatDate(claim.createdAt)}',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text('Proof: ${claim.message}'),
            if (item != null) ...[
              const SizedBox(height: 4),
              Text(
                'Item status: ${item!.status.name}',
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (claim.status == ClaimStatus.pending) ...[
              const SizedBox(height: 12),
              if (!canApprove)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'This item is no longer available, so the claim '
                    'cannot be approved.',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    key: Key('reject-${claim.id}'),
                    onPressed: isWorking ? null : () => _reject(context, ref),
                    child: const Text('Reject'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    key: Key('approve-${claim.id}'),
                    onPressed: (isWorking || !canApprove)
                        ? null
                        : () => _approve(context, ref),
                    child: const Text('Approve'),
                  ),
                ],
              ),
            ],
            if (canMarkReturned) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  key: Key('return-${claim.id}'),
                  onPressed: isWorking
                      ? null
                      : () => _markReturned(context, ref),
                  icon: const Icon(Icons.assignment_turned_in_outlined),
                  label: const Text('Mark item returned'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ClaimStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Color background = colors.tertiaryContainer;
    String label = 'Pending';
    if (status == ClaimStatus.approved) {
      background = colors.primaryContainer;
      label = 'Approved';
    } else if (status == ClaimStatus.rejected) {
      background = colors.errorContainer;
      label = 'Rejected';
    }

    return Chip(
      label: Text(label),
      backgroundColor: background,
      side: BorderSide.none,
    );
  }
}
