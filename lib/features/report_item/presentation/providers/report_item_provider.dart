import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/image_picker_service.dart';
import '../../domain/models/report_item_enums.dart';
import '../../domain/models/report_item_state.dart';

class ReportItemNotifier extends Notifier<ReportItemState> {
  @override
  ReportItemState build() {
    return const ReportItemState();
  }

  void setReportType(ReportType type) {
    state = state.copyWith(
      reportType: type,
      handoverPoint: type == ReportType.lost ? '' : state.handoverPoint,
    );
  }

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  void setCategory(ItemCategory? value) {
    state = state.copyWith(category: value);
  }

  void setLocation(String value) {
    state = state.copyWith(location: value);
  }

  void setHandoverPoint(String value) {
    state = state.copyWith(handoverPoint: value);
  }

  Future<void> pickImage(ReportImageSource source) async {
    if (state.isPickingImage) return;

    state = state.copyWith(isPickingImage: true, imageError: null);

    try {
      final imagePicker = ref.read(imagePickerServiceProvider);
      final image = await imagePicker.pickImage(source);

      if (!ref.mounted) return;

      state = state.copyWith(
        selectedImage: image ?? state.selectedImage,
        isPickingImage: false,
        imageError: null,
      );
    } on PlatformException {
      if (!ref.mounted) return;

      state = state.copyWith(
        isPickingImage: false,
        imageError: 'Unable to access the selected image source.',
      );
    } catch (_) {
      if (!ref.mounted) return;

      state = state.copyWith(
        isPickingImage: false,
        imageError: 'Something went wrong while selecting the image.',
      );
    }
  }

  void removeImage() {
    state = state.copyWith(selectedImage: null, imageError: null);
  }

  void setSubmitting(bool value) {
    state = state.copyWith(isSubmitting: value);
  }

  void setImageError(String? value) {
    state = state.copyWith(imageError: value);
  }

  void reset() {
    state = ReportItemState(formRevision: state.formRevision + 1);
  }
}

final reportItemProvider =
    NotifierProvider<ReportItemNotifier, ReportItemState>(
      ReportItemNotifier.new,
      isAutoDispose: true,
    );
