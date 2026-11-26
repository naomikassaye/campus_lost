import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/domain/item_repository.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';

class InMemoryItemRepository implements ItemRepository {
  InMemoryItemRepository() : _items = [..._seed];

  final List<ItemReport> _items;
  int _nextId = 100;

  @override
  Future<List<ItemReport>> getAll() async => List.unmodifiable(_items);

  @override
  Future<ItemReport?> getById(String id) async =>
      _items.where((i) => i.id == id).firstOrNull;

  @override
  Future<ItemReport> add(ItemReport item) async {
    final saved = item.copyWith(id: 'item-${_nextId++}');
    _items.insert(0, saved);
    return saved;
  }

  @override
  Future<ItemReport> updateStatus(String id, ItemStatus status) async {
    final index = _items.indexWhere((i) => i.id == id);
    if (index == -1) throw StateError('Item $id not found');
    final updated = _items[index].copyWith(status: status);
    _items[index] = updated;
    return updated;
  }

  static final _seed = <ItemReport>[
    ItemReport(
      id: 'item-1',
      type: ReportType.lost,
      title: 'Black wallet',
      description: 'Leather wallet with a student ID card inside.',
      category: ItemCategory.ids,
      location: '4 Kilo',
      reporterId: 'user-1',
      createdAt: DateTime(2026, 11, 20),
    ),
    ItemReport(
      id: 'item-2',
      type: ReportType.found,
      title: 'Set of keys',
      description: 'Three keys on a blue keyring.',
      category: ItemCategory.keys,
      location: '5 Kilo',
      handoverPoint: 'Guard desk',
      reporterId: 'custodian-1',
      createdAt: DateTime(2026, 11, 21),
      status: ItemStatus.held,
    ),
    ItemReport(
      id: 'item-3',
      type: ReportType.found,
      title: 'Scientific calculator',
      description: 'Casio calculator with a blue cover.',
      category: ItemCategory.calculators,
      location: '6 Kilo',
      handoverPoint: 'Library desk',
      reporterId: 'custodian-1',
      createdAt: DateTime(2026, 11, 22),
      status: ItemStatus.held,
    ),
    ItemReport(
      id: 'item-4',
      type: ReportType.lost,
      title: 'Phone charger',
      description: 'White USB-C charger left in a lecture hall.',
      category: ItemCategory.chargers,
      location: '4 Kilo',
      reporterId: 'user-1',
      createdAt: DateTime(2026, 11, 23),
    ),
    ItemReport(
      id: 'item-5',
      type: ReportType.found,
      title: 'Student ID card',
      description: 'ID card found near the cafeteria.',
      category: ItemCategory.ids,
      location: '5 Kilo',
      handoverPoint: 'Guard desk',
      reporterId: 'custodian-1',
      createdAt: DateTime(2026, 11, 19),
      status: ItemStatus.returned,
    ),
  ];
}
