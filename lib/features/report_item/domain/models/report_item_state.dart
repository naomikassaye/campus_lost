import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import 'report_item_enums.dart';

part 'report_item_state.freezed.dart';

@freezed
abstract class ReportItemState with _$ReportItemState {
  const factory ReportItemState({
    @Default(ReportType.lost) ReportType reportType,
    @Default('') String title,
    @Default('') String description,
    ItemCategory? category,
    @Default('') String location,
    @Default('') String handoverPoint,
    XFile? selectedImage,
    @Default(false) bool isSubmitting,
    @Default(false) bool isPickingImage,
    String? imageError,
    @Default(0) int formRevision,
  }) = _ReportItemState;
}
