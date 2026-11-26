import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/feed/data/in_memory_item_repository.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/domain/item_repository.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';

final itemRepositoryProvider = Provider<ItemRepository>(
  (ref) => InMemoryItemRepository(),
);

class ItemsNotifier extends AsyncNotifier<List<ItemReport>> {
  @override
  Future<List<ItemReport>> build() =>
      ref.watch(itemRepositoryProvider).getAll();

  Future<void> add(ItemReport item) async {
    await ref.read(itemRepositoryProvider).add(item);
    ref.invalidateSelf();
    await future;
  }

  Future<void> updateStatus(String id, ItemStatus status) async {
    await ref.read(itemRepositoryProvider).updateStatus(id, status);
    ref.invalidateSelf();
    await future;
  }
}

final itemsProvider = AsyncNotifierProvider<ItemsNotifier, List<ItemReport>>(
  ItemsNotifier.new,
);

final itemByIdProvider = Provider.family<AsyncValue<ItemReport?>, String>((
  ref,
  id,
) {
  return ref
      .watch(itemsProvider)
      .whenData((items) => items.where((i) => i.id == id).firstOrNull);
});
