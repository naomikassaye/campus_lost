import 'package:flutter/material.dart';
import 'package:campus_lost/core/widgets/placeholder_page.dart';

class ClaimFormScreen extends StatelessWidget {
  const ClaimFormScreen({required this.itemId, super.key});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(title: 'Claim Item: $itemId');
  }
}
