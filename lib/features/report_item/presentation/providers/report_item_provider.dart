import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

enum ReportType { lost, found }

class ReportItemState {
  final ReportType reportType;
  final String title;
  final String description;
  final String category;
  final String location;
  final String handoverPoint;
  final XFile? selectedImage;
  final bool isSubmitting;
  final String? imageError;

  const ReportItemState({
    this.reportType = ReportType.lost,
    this.title = '',
    this.description = '',
    this.category = '',
    this.location = '',
    this.handoverPoint = '',
    this.selectedImage,
    this.isSubmitting = false,
    this.imageError,
  });

  ReportItemState copyWith({
    ReportType? reportType,
    String? title,
    String? description,
    String? category,
    String? location,
    String? handoverPoint,
    XFile? selectedImage,
    bool clearImage = false,
    bool? isSubmitting,
    String? imageError,
    bool clearImageError = false,
  }) {
    return ReportItemState(
      reportType: reportType ?? this.reportType,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      handoverPoint: handoverPoint ?? this.handoverPoint,
      selectedImage: clearImage ? null : selectedImage ?? this.selectedImage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      imageError: clearImageError ? null : imageError ?? this.imageError,
    );
  }
}

class ReportItemNotifier extends Notifier<ReportItemState> {
  @override
  ReportItemState build() {
    return const ReportItemState();
  }

  void setReportType(ReportType type) {
    state = state.copyWith(reportType: type);
  }

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  void setCategory(String value) {
    state = state.copyWith(category: value);
  }

  void setLocation(String value) {
    state = state.copyWith(location: value);
  }

  void setHandoverPoint(String value) {
    state = state.copyWith(handoverPoint: value);
  }

  Future<void> pickImage(ImageSource source) async {
    state = state.copyWith(clearImageError: true);

    try {
      final picker = ImagePicker();

      final image = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1600,
      );

      if (image != null) {
        state = state.copyWith(selectedImage: image, clearImageError: true);
      }
    } on PlatformException {
      state = state.copyWith(
        imageError: 'Unable to access the selected image source.',
      );
    } catch (_) {
      state = state.copyWith(
        imageError: 'Something went wrong while selecting the image.',
      );
    }
  }

  void removeImage() {
    state = state.copyWith(clearImage: true, clearImageError: true);
  }

  void setSubmitting(bool value) {
    state = state.copyWith(isSubmitting: value);
  }

  void reset() {
    state = const ReportItemState();
  }
}

final reportItemProvider =
    NotifierProvider<ReportItemNotifier, ReportItemState>(
      ReportItemNotifier.new,
    );
