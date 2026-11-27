import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/claim/presentation/providers/claims_provider.dart';
import 'package:campus_lost/features/feed/presentation/providers/items_provider.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';

class MyActivityScreen extends ConsumerWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final itemsAsync = ref.watch(itemsProvider);
    final claimsAsync = ref.watch(claimsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Activity')),
      body: user == null
          ? const Center(child: Text('Please sign in to see your activity.'))
          : itemsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Center(child: Text('Could not load items: $error')),
              data: (items) => claimsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    Center(child: Text('Could not load claims: $error')),
                data: (claims) {
                  final myItems = items
                      .where((i) => i.reporterId == user.id)
                      .toList();
                  final myClaims = claims
                      .where((c) => c.claimantId == user.id)
                      .toList();

                  String titleFor(String itemId) {
                    for (final item in items) {
                      if (item.id == itemId) return item.title;
                    }
                    return 'Item $itemId';
                  }

                  final titleStyle = Theme.of(context).textTheme.titleLarge;

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text('My reports', style: titleStyle),
                      const SizedBox(height: 8),
                      if (myItems.isEmpty)
                        const Text('You have not reported any items yet.'),
                      for (final item in myItems)
                        Card(
                          child: ListTile(
                            title: Text(item.title),
                            subtitle: Text(
                              '${item.type == ReportType.lost ? 'Lost' : 'Found'}'
                              ' · ${item.category.label} · ${item.location}',
                            ),
                            trailing: Text(item.status.name),
                            onTap: () =>
                                context.push(AppRoutes.itemDetails(item.id)),
                          ),
                        ),
                      const SizedBox(height: 24),
                      Text('My claims', style: titleStyle),
                      const SizedBox(height: 8),
                      if (myClaims.isEmpty)
                        const Text('You have not claimed any items yet.'),
                      for (final claim in myClaims)
                        Card(
                          child: ListTile(
                            title: Text(titleFor(claim.itemId)),
                            subtitle: Text(claim.message),
                            trailing: Text(claim.status.name),
                            onTap: () => context.push(
                              AppRoutes.itemDetails(claim.itemId),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
