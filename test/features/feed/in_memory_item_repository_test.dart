import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/feed/data/in_memory_item_repository.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';
import 'package:campus_lost/features/feed/presentation/providers/items_provider.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';

ItemReport _newItem() => ItemReport(
  id: '',
  type: ReportType.lost,
  title: 'Phone charger',
  description: 'Black charger with a long cable.',
  category: ItemCategory.chargers,
  location: '4 Kilo',
  reporterId: 'user-1',
  createdAt: DateTime(2026, 11, 25),
);

void main() {
  late InMemoryItemRepository repo;

  setUp(() => repo = InMemoryItemRepository());

  test('getAll returns the seeded items', () async {
    expect(await repo.getAll(), isNotEmpty);
  });

  test('add assigns an id and puts the item first', () async {
    final saved = await repo.add(_newItem());
    expect(saved.id, isNotEmpty);
    expect((await repo.getAll()).first.id, saved.id);
  });

  test('updateStatus changes the item status', () async {
    final updated = await repo.updateStatus('item-2', ItemStatus.claimed);
    expect(updated.status, ItemStatus.claimed);
    expect((await repo.getById('item-2'))!.status, ItemStatus.claimed);
  });

  test(
    'getById returns null and updateStatus throws for unknown ids',
    () async {
      expect(await repo.getById('missing'), isNull);
      expect(
        () => repo.updateStatus('missing', ItemStatus.claimed),
        throwsStateError,
      );
    },
  );

  test('itemsProvider reflects a newly added item', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final before = await container.read(itemsProvider.future);
    await container.read(itemsProvider.notifier).add(_newItem());
    final after = container.read(itemsProvider).requireValue;

    expect(after.length, before.length + 1);
  });
}
