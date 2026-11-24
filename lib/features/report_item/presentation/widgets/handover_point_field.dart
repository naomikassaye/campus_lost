import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/report_item_provider.dart';

class HandoverPointField extends ConsumerWidget {
  const HandoverPointField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(reportItemProvider);
    final notifier = ref.read(reportItemProvider.notifier);

    if (report.reportType != ReportType.found) {
      return const SizedBox.shrink();
    }

    return TextFormField(
      initialValue: report.handoverPoint,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'Handover Point',
        hintText: 'Where can the owner collect the item?',
        prefixIcon: Icon(Icons.place_outlined),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a handover point.';
        }

        if (value.trim().length < 3) {
          return 'Handover point must contain at least 3 characters.';
        }

        return null;
      },
      onChanged: notifier.setHandoverPoint,
    );
  }
}
