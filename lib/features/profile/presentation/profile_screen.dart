import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/core/theme/theme_mode_provider.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/profile/presentation/providers/profile_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _confirmingClear = false;

  Future<void> _confirmClearCache() async {
    await ref.read(cacheMaintenanceProvider).clear();
    if (!mounted) return;
    setState(() => _confirmingClear = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Cached data cleared.')));
  }

  Future<void> _signOut() async {
    await ref.read(authControllerProvider.notifier).signOut();
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final themeMode = ref.watch(themeModeProvider);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile & Settings')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('You are not signed in.'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.go(AppRoutes.login),
                child: const Text('Go to sign in'),
              ),
            ],
          ),
        ),
      );
    }

    final initial = user.fullName.isEmpty
        ? '?'
        : user.fullName[0].toUpperCase();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(radius: 28, child: Text(initial)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(user.email, style: theme.textTheme.bodySmall),
                          const SizedBox(height: 8),
                          Chip(
                            label: Text(
                              user.isCustodian ? 'Custodian' : 'Student',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (user.isCustodian) ...[
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.fact_check_outlined),
                  title: const Text('Review claims'),
                  subtitle: const Text('Confirm receipts and decide claims'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(AppRoutes.reviewClaims),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Text('Appearance', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.brightness_auto),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (selection) =>
                  ref.read(themeModeProvider.notifier).setMode(selection.first),
            ),
            const SizedBox(height: 24),
            Text('Data', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Clear cached data'),
                    subtitle: const Text('Remove recent items and drafts'),
                    onTap: () => setState(() => _confirmingClear = true),
                  ),
                  if (_confirmingClear)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Clear cached data? Recent items and unsent drafts will be removed.',
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    setState(() => _confirmingClear = false),
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 8),
                              FilledButton(
                                onPressed: _confirmClearCache,
                                child: const Text('Clear'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
              label: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
