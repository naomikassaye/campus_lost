import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/profile/data/in_memory_cache_maintenance.dart';
import 'package:campus_lost/features/profile/domain/cache_maintenance.dart';

final cacheMaintenanceProvider = Provider<CacheMaintenance>(
  (ref) => InMemoryCacheMaintenance(),
);
