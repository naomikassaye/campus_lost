import 'package:campus_lost/features/claim/domain/claim_repository.dart';
import 'package:campus_lost/features/claim/domain/claim_request.dart';
import 'package:campus_lost/features/claim/domain/claim_status.dart';

class InMemoryClaimRepository implements ClaimRepository {
  InMemoryClaimRepository() : _claims = [..._seed];

  final List<ClaimRequest> _claims;
  int _nextId = 100;

  @override
  Future<List<ClaimRequest>> getAll() async => List.unmodifiable(_claims);

  @override
  Future<List<ClaimRequest>> getForItem(String itemId) async =>
      _claims.where((c) => c.itemId == itemId).toList();

  @override
  Future<List<ClaimRequest>> getForUser(String userId) async =>
      _claims.where((c) => c.claimantId == userId).toList();

  @override
  Future<ClaimRequest> add(ClaimRequest claim) async {
    final saved = claim.copyWith(id: 'claim-${_nextId++}');
    _claims.insert(0, saved);
    return saved;
  }

  @override
  Future<ClaimRequest> updateStatus(String id, ClaimStatus status) async {
    final index = _claims.indexWhere((c) => c.id == id);
    if (index == -1) throw StateError('Claim $id not found');
    final updated = _claims[index].copyWith(status: status);
    _claims[index] = updated;
    return updated;
  }

  static final _seed = <ClaimRequest>[
    ClaimRequest(
      id: 'claim-1',
      itemId: 'item-2',
      claimantId: 'user-1',
      claimantName: 'Selam Kebede',
      message: 'The keyring has a small silver tag with my initials.',
      createdAt: DateTime(2026, 11, 22),
    ),
    ClaimRequest(
      id: 'claim-2',
      itemId: 'item-2',
      claimantId: 'user-3',
      claimantName: 'Dawit Alemu',
      message: 'I lost these near the library on Monday.',
      status: ClaimStatus.rejected,
      createdAt: DateTime(2026, 11, 23),
    ),
  ];
}
