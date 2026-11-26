/// Clears locally cached data (recent items, drafts).
abstract interface class CacheMaintenance {
  Future<void> clear();
}
