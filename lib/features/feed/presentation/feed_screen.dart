
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/features/feed/domain/item_report.dart';
import 'package:campus_lost/features/feed/domain/item_status.dart';
import 'package:campus_lost/features/feed/presentation/providers/items_provider.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final _searchController = TextEditingController();

  ReportType? _typeFilter;
  ItemCategory? _categoryFilter;
  ItemStatus? _statusFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ItemReport> _filterItems(List<ItemReport> items) {
    final query = _searchController.text.trim().toLowerCase();

    return items.where((item) {
      final matchesSearch =
          item.title.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query);

      final matchesType = _typeFilter == null || item.type == _typeFilter;

      final matchesCategory =
          _categoryFilter == null || item.category == _categoryFilter;

      final matchesStatus =
          _statusFilter == null || item.status == _statusFilter;

      return matchesSearch &&
          matchesType &&
          matchesCategory &&
          matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusLost'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
              ),
            ),
          ),
          _buildFilters(),
          Expanded(
            child: itemsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Could not load items.'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(itemsProvider),
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
              data: (items) {
                final filteredItems = _filterItems(items);

                if (items.isEmpty) {
                  return const Center(
                    child: Text('No items have been reported yet.'),
                  );
                }

                if (filteredItems.isEmpty) {
                  return const Center(
                    child: Text(
                      'No items match your search or filters.',
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            item.type == ReportType.lost
                                ? Icons.search
                                : Icons.inventory_2_outlined,
                          ),
                        ),
                        title: Text(item.title),
                        subtitle: Text(
                          '${item.type.label.toUpperCase()} • '
                          '${item.category.label} • ${item.location}\n'
                          '${item.description}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(item.status.label),
                        isThreeLine: true,
                        onTap: () {
                          context.push(
                            AppRoutes.itemDetails(item.id),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          DropdownButton<ReportType?>(
            value: _typeFilter,
            hint: const Text('Type'),
            items: [
              const DropdownMenuItem<ReportType?>(
                value: null,
                child: Text('All types'),
              ),
              ...ReportType.values.map(
                (type) => DropdownMenuItem<ReportType?>(
                  value: type,
                  child: Text(type.label.toUpperCase()),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() => _typeFilter = value);
            },
          ),
          DropdownButton<ItemCategory?>(
            value: _categoryFilter,
            hint: const Text('Category'),
            items: [
              const DropdownMenuItem<ItemCategory?>(
                value: null,
                child: Text('All categories'),
              ),
              ...ItemCategory.values.map(
                (category) => DropdownMenuItem<ItemCategory?>(
                  value: category,
                  child: Text(category.label),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() => _categoryFilter = value);
            },
          ),
          DropdownButton<ItemStatus?>(
            value: _statusFilter,
            hint: const Text('Status'),
            items: [
              const DropdownMenuItem<ItemStatus?>(
                value: null,
                child: Text('All statuses'),
              ),
              ...ItemStatus.values.map(
                (status) => DropdownMenuItem<ItemStatus?>(
                  value: status,
                  child: Text(status.label),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() => _statusFilter = value);
            },
          ),
        ],
      ),
    );
  }
}
