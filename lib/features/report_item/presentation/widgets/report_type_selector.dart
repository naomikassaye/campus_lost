import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/report_item_provider.dart';

class ReportTypeSelector extends ConsumerWidget {
  const ReportTypeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportType = ref.watch(
      reportItemProvider.select((state) => state.reportType),
    );

    final notifier = ref.read(reportItemProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What would you like to report?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ReportTypeCard(
                title: 'Lost Item',
                subtitle: 'I lost something',
                icon: Icons.search,
                isSelected: reportType == ReportType.lost,
                onTap: () => notifier.setReportType(ReportType.lost),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ReportTypeCard(
                title: 'Found Item',
                subtitle: 'I found something',
                icon: Icons.inventory_2_outlined,
                isSelected: reportType == ReportType.found,
                onTap: () => notifier.setReportType(ReportType.found),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ReportTypeCard extends StatelessWidget {
  const _ReportTypeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
