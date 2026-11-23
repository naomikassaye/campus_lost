import 'package:flutter/material.dart';
import 'package:campus_lost/core/widgets/placeholder_page.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({required this.itemId, super.key});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(title: 'Item Details: $itemId');
  }
}
