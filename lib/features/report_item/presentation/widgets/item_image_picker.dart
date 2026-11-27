import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:campus_lost/features/report_item/data/services/image_picker_service.dart';
import 'package:campus_lost/features/report_item/presentation/providers/report_item_provider.dart';

class ItemImagePicker extends ConsumerStatefulWidget {
  const ItemImagePicker({super.key});

  @override
  ConsumerState<ItemImagePicker> createState() => _ItemImagePickerState();
}

class _ItemImagePickerState extends ConsumerState<ItemImagePicker> {
  String? _loadedImagePath;
  Future<Uint8List>? _imageBytesFuture;

  void _prepareImagePreview(XFile? image) {
    if (image == null) {
      _loadedImagePath = null;
      _imageBytesFuture = null;
      return;
    }

    if (_loadedImagePath != image.path) {
      _loadedImagePath = image.path;
      _imageBytesFuture = image.readAsBytes();
    }
  }

  Future<void> _showImageSourceOptions(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final source = await showModalBottomSheet<ReportImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Choose image source',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context, ReportImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context, ReportImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );

    if (source != null && context.mounted) {
      await ref.read(reportItemProvider.notifier).pickImage(source);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedImage = ref.watch(
      reportItemProvider.select((state) => state.selectedImage),
    );

    final imageError = ref.watch(
      reportItemProvider.select((state) => state.imageError),
    );

    final isPickingImage = ref.watch(
      reportItemProvider.select((state) => state.isPickingImage),
    );

    final notifier = ref.read(reportItemProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    _prepareImagePreview(selectedImage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Image', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        if (selectedImage != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FutureBuilder<Uint8List>(
              future: _imageBytesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: const Text('Unable to display this image.'),
                  );
                }

                return Image.memory(
                  snapshot.data!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: colorScheme.surfaceContainerHighest,
                      alignment: Alignment.center,
                      child: const Text('Unable to display this image.'),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton.icon(
                onPressed: isPickingImage
                    ? null
                    : () => _showImageSourceOptions(context, ref),
                icon: const Icon(Icons.edit),
                label: const Text('Change image'),
              ),
              TextButton.icon(
                onPressed: isPickingImage ? null : notifier.removeImage,
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
                  onPressed: isPickingImage
                      ? null
                      : () => _showImageSourceOptions(context, ref),
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('Add image'),
                ),
              ),
            ],
          ),
        ],
        if (isPickingImage) ...[
          const SizedBox(height: 12),
          const Center(child: CircularProgressIndicator()),
        ],
        if (imageError != null) ...[
          const SizedBox(height: 8),
          Text(imageError, style: TextStyle(color: colorScheme.error)),
        ],
      ],
    );
  }
}
