import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';

abstract interface class ClaimRepository {
  Future<List<ClaimRequest>> getAll();
  Future<List<ClaimRequest>> getForItem(String itemId);
  Future<List<ClaimRequest>> getForUser(String userId);
  Future<ClaimRequest> add(ClaimRequest claim);
  Future<ClaimRequest> updateStatus(String id, ClaimStatus status);
}
