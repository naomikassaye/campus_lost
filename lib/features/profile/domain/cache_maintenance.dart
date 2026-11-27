/// Clears locally cached data (recent items, drafts).
abstract interface class CacheMaintenance {
  Future<void> save(String key, String value);
  Future<String?> read(String key);
  Future<void> clear();
}
