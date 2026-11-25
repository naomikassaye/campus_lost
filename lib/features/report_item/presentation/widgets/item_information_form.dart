import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';
import 'package:campus_lost/features/report_item/presentation/providers/report_item_provider.dart';

class ItemInformationForm extends ConsumerWidget {
  const ItemInformationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(reportItemProvider.select((state) => state.title));

    final description = ref.watch(
      reportItemProvider.select((state) => state.description),
    );

    final category = ref.watch(
      reportItemProvider.select((state) => state.category),
    );

    final location = ref.watch(
      reportItemProvider.select((state) => state.location),
    );

    final notifier = ref.read(reportItemProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: title,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Item Name',
            hintText: 'Enter the name of the item',
          ),
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
          initialValue: description,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Describe the item and its identifying features',
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

        DropdownButtonFormField<ItemCategory>(
          initialValue: category,
          decoration: const InputDecoration(labelText: 'Category'),
          items: ItemCategory.values.map((itemCategory) {
            return DropdownMenuItem<ItemCategory>(
              value: itemCategory,
              child: Text(itemCategory.label),
            );
          }).toList(),
          validator: (value) {
            if (value == null) {
              return 'Please select a category.';
            }

            return null;
          },
          onChanged: notifier.setCategory,
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue: location,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Location',
            hintText: 'Where was the item lost or found?',
            prefixIcon: Icon(Icons.location_on_outlined),
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
