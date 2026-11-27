import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/features/feed/presentation/providers/items_provider.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';

class ItemDetailsScreen extends ConsumerWidget {
  const ItemDetailsScreen({required this.itemId, super.key});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(itemByIdProvider(itemId));
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: itemAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Something went wrong: $error')),
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Item not found.'));
          }

          final canClaim =
              user != null && item.isClaimable && item.reporterId != user.id;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                item.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(item.description),
              const SizedBox(height: 16),
              Text('Type: ${item.type.label}'),
              Text('Category: ${item.category.label}'),
              Text('Location: ${item.location}'),
              Text('Status: ${item.status.label}'),
              if (item.handoverPoint != null)
                Text('Handover point: ${item.handoverPoint}'),
              const SizedBox(height: 24),
              if (canClaim)
                FilledButton(
                  onPressed: () {
                    context.push(AppRoutes.claimForm(item.id));
                  },
                  child: const Text('Claim Item'),
                ),
            ],
          );
        },
      ),
    );
  }
}
