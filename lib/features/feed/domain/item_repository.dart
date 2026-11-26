import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';

abstract interface class ItemRepository {
  Future<List<ItemReport>> getAll();
  Future<ItemReport?> getById(String id);
  Future<ItemReport> add(ItemReport item);
  Future<ItemReport> updateStatus(String id, ItemStatus status);
}
