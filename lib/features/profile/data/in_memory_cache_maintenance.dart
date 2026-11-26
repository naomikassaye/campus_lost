import 'package:campus_lost/features/profile/domain/cache_maintenance.dart';

class InMemoryCacheMaintenance implements CacheMaintenance {
  int clearCount = 0;

  @override
  Future<void> clear() async {
    clearCount++;
  }
}
