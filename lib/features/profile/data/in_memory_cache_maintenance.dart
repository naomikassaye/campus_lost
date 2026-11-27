import 'package:campus_lost/features/profile/domain/cache_maintenance.dart';

// Placeholder store for Milestone 1.

class InMemoryCacheMaintenance implements CacheMaintenance {
  final Map<String, String> _entries = {};

  @override
  Future<void> save(String key, String value) async {
    _entries[key] = value;
  }

  @override
  Future<String?> read(String key) async => _entries[key];

  @override
  Future<void> clear() async {
    _entries.clear();
  }
}
