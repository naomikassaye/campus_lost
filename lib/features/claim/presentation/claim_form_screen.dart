import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';

import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/presentation/providers/claims_provider.dart';
import 'package:campus_lost/features/feed/presentation/providers/items_provider.dart';

class ClaimFormScreen extends ConsumerStatefulWidget {
  const ClaimFormScreen({required this.itemId, super.key});

  final String itemId;

  @override
  ConsumerState<ClaimFormScreen> createState() => _ClaimFormScreenState();
}

class _ClaimFormScreenState extends ConsumerState<ClaimFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitClaim() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _isSubmitting = true);

    final claim = ClaimRequest(
      id: 'new-claim',
      itemId: widget.itemId,
      claimantId: user.id,
      claimantName: user.fullName,
      message: _messageController.text.trim(),
      createdAt: DateTime.now(),
    );

    try {
      await ref.read(claimsProvider.notifier).add(claim);
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to submit claim.')));
      return;
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Claim submitted successfully.')),
    );

    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.itemDetails(widget.itemId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemAsync = ref.watch(itemByIdProvider(widget.itemId));
    final claimsAsync = ref.watch(claimsProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Claim Item')),
      body: itemAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('Could not load item.')),
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Item not found.'));
          }

          if (!item.isClaimable) {
            return const Center(
              child: Text('This item is no longer available to claim.'),
            );
          }

          if (user == null) {
            return const Center(
              child: Text('Please sign in to claim this item.'),
            );
          }

          if (item.reporterId == user.id) {
            return const Center(
              child: Text('You cannot claim an item you reported.'),
            );
          }

          return claimsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                const Center(child: Text('Could not load claims.')),
            data: (claims) {
              final alreadyClaimed = claims.any(
                (claim) =>
                    claim.itemId == widget.itemId &&
                    claim.claimantId == user.id,
              );

              if (alreadyClaimed) {
                return const Center(
                  child: Text(
                    'You have already submitted a claim for this item.',
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text('Location: ${item.location}'),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _messageController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Why is this item yours?',
                          hintText: 'Describe details that can help verify ownership.',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please explain why this item is yours.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: _isSubmitting ? null : _submitClaim,
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Submit Claim'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
