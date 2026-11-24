import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/report_item_provider.dart';

class ItemImagePicker extends ConsumerWidget {
  const ItemImagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(reportItemProvider);
    final notifier = ref.read(reportItemProvider.notifier);
    final selectedImage = report.selectedImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Item Image',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        if (selectedImage != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(selectedImage.path),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  notifier.pickImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.edit),
                label: const Text('Change image'),
              ),
              TextButton.icon(
                onPressed: notifier.removeImage,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remove image'),
              ),
            ],
          ),
        ] else ...[
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    notifier.pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Gallery'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    notifier.pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Camera'),
                ),
              ),
            ],
          ),
        ],

        if (report.imageError != null) ...[
          const SizedBox(height: 8),
          Text(
            report.imageError!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }
}
