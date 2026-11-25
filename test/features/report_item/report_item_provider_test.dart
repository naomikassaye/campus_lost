import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

import 'package:campus_lost/features/report_item/data/services/image_picker_service.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';
import 'package:campus_lost/features/report_item/presentation/providers/report_item_provider.dart';

class FakeImagePickerService implements ImagePickerService {
  XFile? imageToReturn;
  Exception? errorToThrow;
  int callCount = 0;

  @override
  Future<XFile?> pickImage(ReportImageSource source) async {
    callCount++;

    if (errorToThrow != null) {
      throw errorToThrow!;
    }

    return imageToReturn;
  }
}

void main() {
  late ProviderContainer container;
  late FakeImagePickerService fakeImagePicker;

  setUp(() {
    fakeImagePicker = FakeImagePickerService();

    container = ProviderContainer(
      overrides: [
        imagePickerServiceProvider.overrideWithValue(fakeImagePicker),
      ],
    );

    // Keep the auto-disposed provider alive during each test.
    container.listen(reportItemProvider, (previous, next) {});
  });

  tearDown(() {
    container.dispose();
  });

  group('ReportItemNotifier', () {
    test('starts with the default Lost report state', () {
      final state = container.read(reportItemProvider);

      expect(state.reportType, ReportType.lost);
      expect(state.title, '');
      expect(state.description, '');
      expect(state.category, isNull);
      expect(state.location, '');
      expect(state.handoverPoint, '');
      expect(state.selectedImage, isNull);
      expect(state.isSubmitting, false);
      expect(state.isPickingImage, false);
    });

    test('changes report type to Found', () {
      container
          .read(reportItemProvider.notifier)
          .setReportType(ReportType.found);

      expect(container.read(reportItemProvider).reportType, ReportType.found);
    });

    test('clears handover point when changing to Lost', () {
      final notifier = container.read(reportItemProvider.notifier);

      notifier.setReportType(ReportType.found);
      notifier.setHandoverPoint('Main Library');

      notifier.setReportType(ReportType.lost);

      final state = container.read(reportItemProvider);

      expect(state.reportType, ReportType.lost);
      expect(state.handoverPoint, '');
    });

    test('preserves handover point when remaining Found', () {
      final notifier = container.read(reportItemProvider.notifier);

      notifier.setReportType(ReportType.found);
      notifier.setHandoverPoint('Main Library');
      notifier.setReportType(ReportType.found);

      expect(container.read(reportItemProvider).handoverPoint, 'Main Library');
    });

    test('updates item information fields', () {
      final notifier = container.read(reportItemProvider.notifier);

      notifier.setTitle('Calculator');
      notifier.setDescription('Black scientific calculator');
      notifier.setCategory(ItemCategory.calculators);
      notifier.setLocation('Computer Science Building');

      final state = container.read(reportItemProvider);

      expect(state.title, 'Calculator');
      expect(state.description, 'Black scientific calculator');
      expect(state.category, ItemCategory.calculators);
      expect(state.location, 'Computer Science Building');
    });

    test('updates handover point', () {
      container
          .read(reportItemProvider.notifier)
          .setHandoverPoint('Student Lounge');

      expect(
        container.read(reportItemProvider).handoverPoint,
        'Student Lounge',
      );
    });

    test('successfully picks an image', () async {
      final image = XFile('test_image.jpg');
      fakeImagePicker.imageToReturn = image;

      await container
          .read(reportItemProvider.notifier)
          .pickImage(ReportImageSource.gallery);

      final state = container.read(reportItemProvider);

      expect(state.selectedImage, image);
      expect(state.isPickingImage, false);
      expect(state.imageError, isNull);
      expect(fakeImagePicker.callCount, 1);
    });

    test('preserves the existing image when selection is cancelled', () async {
      final existingImage = XFile('existing_image.jpg');
      fakeImagePicker.imageToReturn = existingImage;

      final notifier = container.read(reportItemProvider.notifier);

      await notifier.pickImage(ReportImageSource.gallery);

      fakeImagePicker.imageToReturn = null;

      await notifier.pickImage(ReportImageSource.camera);

      final state = container.read(reportItemProvider);

      expect(state.selectedImage, existingImage);
      expect(state.isPickingImage, false);
      expect(state.imageError, isNull);
    });

    test('removes the selected image', () async {
      fakeImagePicker.imageToReturn = XFile('test_image.jpg');

      final notifier = container.read(reportItemProvider.notifier);

      await notifier.pickImage(ReportImageSource.gallery);
      notifier.removeImage();

      final state = container.read(reportItemProvider);

      expect(state.selectedImage, isNull);
      expect(state.imageError, isNull);
    });

    test('handles platform exceptions during image selection', () async {
      fakeImagePicker.errorToThrow = PlatformException(code: 'camera_error');

      await container
          .read(reportItemProvider.notifier)
          .pickImage(ReportImageSource.camera);

      final state = container.read(reportItemProvider);

      expect(state.selectedImage, isNull);
      expect(state.isPickingImage, false);
      expect(state.imageError, 'Unable to access the selected image source.');
    });

    test('handles unexpected image picker exceptions', () async {
      fakeImagePicker.errorToThrow = Exception('Unexpected error');

      await container
          .read(reportItemProvider.notifier)
          .pickImage(ReportImageSource.gallery);

      final state = container.read(reportItemProvider);

      expect(state.isPickingImage, false);
      expect(
        state.imageError,
        'Something went wrong while selecting the image.',
      );
    });

    test('prevents concurrent image picker operations', () async {
      // This test checks that a second request is ignored while
      // the first image picker request is still running.
      final completer = _DelayedImagePickerService();

      final testContainer = ProviderContainer(
        overrides: [imagePickerServiceProvider.overrideWithValue(completer)],
      );

      final subscription = testContainer.listen(
        reportItemProvider,
        (previous, next) {},
      );

      addTearDown(() {
        subscription.close();
        testContainer.dispose();
      });

      final notifier = testContainer.read(reportItemProvider.notifier);

      final firstRequest = notifier.pickImage(ReportImageSource.gallery);

      await Future<void>.delayed(Duration.zero);

      await notifier.pickImage(ReportImageSource.camera);

      expect(completer.callCount, 1);

      completer.complete();

      await firstRequest;

      expect(testContainer.read(reportItemProvider).isPickingImage, false);
    });

    test('reset clears fields and increments form revision', () {
      final notifier = container.read(reportItemProvider.notifier);

      notifier.setTitle('Lost calculator');
      notifier.setDescription('Black calculator');
      notifier.setLocation('Library');

      final previousRevision = container.read(reportItemProvider).formRevision;

      notifier.reset();

      final state = container.read(reportItemProvider);

      expect(state.title, '');
      expect(state.description, '');
      expect(state.location, '');
      expect(state.category, isNull);
      expect(state.reportType, ReportType.lost);
      expect(state.formRevision, previousRevision + 1);
    });

    test('updates submitting state', () {
      final notifier = container.read(reportItemProvider.notifier);

      notifier.setSubmitting(true);

      expect(container.read(reportItemProvider).isSubmitting, true);

      notifier.setSubmitting(false);

      expect(container.read(reportItemProvider).isSubmitting, false);
    });

    test('updates image error', () {
      final notifier = container.read(reportItemProvider.notifier);

      notifier.setImageError('Photo required');

      expect(container.read(reportItemProvider).imageError, 'Photo required');

      notifier.setImageError(null);

      expect(container.read(reportItemProvider).imageError, isNull);
    });
  });
}

class _DelayedImagePickerService implements ImagePickerService {
  int callCount = 0;

  final Completer<XFile?> _completer = Completer<XFile?>();

  void complete() {
    _completer.complete(null);
  }

  @override
  Future<XFile?> pickImage(ReportImageSource source) {
    callCount++;
    return _completer.future;
  }
}
