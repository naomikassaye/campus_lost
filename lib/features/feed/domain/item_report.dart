import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:campus_lost/features/feed/domain/item_status.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';

part 'item_report.freezed.dart';

@freezed
abstract class ItemReport with _$ItemReport {
  const factory ItemReport({
    required String id,
    required ReportType type,
    required String title,
    required String description,
    required ItemCategory category,
    required String location,
    String? handoverPoint,
    String? imageUrl,
    required String reporterId,
    required DateTime createdAt,
    @Default(ItemStatus.open) ItemStatus status,
  }) = _ItemReport;
}

extension ItemReportClaimable on ItemReport {
  bool get isClaimable =>
      type == ReportType.found &&
      (status == ItemStatus.open || status == ItemStatus.held);
}
