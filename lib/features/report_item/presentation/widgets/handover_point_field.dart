import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';
import 'package:campus_lost/features/report_item/presentation/providers/report_item_provider.dart';

class HandoverPointField extends ConsumerWidget {
  const HandoverPointField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportType = ref.watch(
      reportItemProvider.select((state) => state.reportType),
    );

    final handoverPoint = ref.watch(
      reportItemProvider.select((state) => state.handoverPoint),
    );

    if (reportType != ReportType.found) {
      return const SizedBox.shrink();
    }

    return TextFormField(
      key: const ValueKey('handoverPointField'),
      initialValue: handoverPoint,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'Handover Point',
        hintText: 'Where can the owner collect the item?',
        prefixIcon: Icon(Icons.place_outlined),
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
      onChanged: ref.read(reportItemProvider.notifier).setHandoverPoint,
    );
  }
}
