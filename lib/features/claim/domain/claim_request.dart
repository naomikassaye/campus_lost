import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:campus_lost/features/claim/domain/claim_status.dart';

part 'claim_request.freezed.dart';

@freezed
abstract class ClaimRequest with _$ClaimRequest {
  const factory ClaimRequest({
    required String id,
    required String itemId,
    required String claimantId,
    required String claimantName,
    required String message,
    @Default(ClaimStatus.pending) ClaimStatus status,
    required DateTime createdAt,
  }) = _ClaimRequest;
}
