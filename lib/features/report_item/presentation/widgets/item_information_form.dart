import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/report_item_provider.dart';

class ItemInformationForm extends ConsumerWidget {
  const ItemInformationForm({super.key});

  static const List<String> categories = [
    'Electronics',
    'Clothing',
    'Books',
    'Accessories',
    'Documents',
    'Other',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(reportItemProvider);
    final notifier = ref.read(reportItemProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: report.title,
          decoration: const InputDecoration(
            labelText: 'Item Name',
            hintText: 'Enter the name of the item',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter the item name.';
            }

            if (value.trim().length < 2) {
              return 'Item name must contain at least 2 characters.';
            }

            return null;
          },
          onChanged: notifier.setTitle,
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue: report.description,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Describe the item and its identifying features',
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please describe the item.';
            }

            if (value.trim().length < 10) {
              return 'Description must contain at least 10 characters.';
            }

            return null;
          },
          onChanged: notifier.setDescription,
        ),

        const SizedBox(height: 16),

        DropdownButtonFormField<String>(
          initialValue: report.category.isEmpty ? null : report.category,
          decoration: const InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
          ),
          items: categories.map((category) {
            return DropdownMenuItem(value: category, child: Text(category));
          }).toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a category.';
            }

            return null;
          },
          onChanged: (value) {
            if (value != null) {
              notifier.setCategory(value);
            }
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue: report.location,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Location',
            hintText: 'Where was the item lost or found?',
            prefixIcon: Icon(Icons.location_on_outlined),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter the location.';
            }

            if (value.trim().length < 3) {
              return 'Location must contain at least 3 characters.';
            }

            return null;
          },
          onChanged: notifier.setLocation,
        ),
      ],
    );
  }
}
