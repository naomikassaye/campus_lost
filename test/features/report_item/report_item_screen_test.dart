import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/auth/domain/auth_user.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/feed/data/in_memory_item_repository.dart';
import 'package:campus_lost/features/feed/presentation/providers/items_provider.dart';
import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';
import 'package:campus_lost/features/report_item/presentation/report_item_screen.dart';

void main() {
  Widget createTestApp({ProviderContainer? container}) {
    if (container != null) {
      return UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ReportItemScreen()),
      );
    }

    return const ProviderScope(child: MaterialApp(home: ReportItemScreen()));
  }

  Future<void> fillLostReport(WidgetTester tester) async {
    final textFields = find.byType(TextFormField);

    await tester.ensureVisible(textFields.at(0));
    await tester.enterText(textFields.at(0), 'Lost calculator');

    await tester.ensureVisible(textFields.at(1));
    await tester.enterText(
      textFields.at(1),
      'Black scientific calculator with a blue cover.',
    );

    await tester.ensureVisible(textFields.at(2));
    await tester.enterText(textFields.at(2), 'Computer Science Building');

    final categoryDropdown = find.byType(DropdownButtonFormField<ItemCategory>);

    // Dismiss the keyboard before interacting with the dropdown.
    tester.testTextInput.hide();
    await tester.pumpAndSettle();

    await tester.ensureVisible(categoryDropdown);
    await tester.pumpAndSettle();
    await tester.tap(categoryDropdown);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Calculators').last);
    await tester.pumpAndSettle();
  }

  group('ReportItemScreen', () {
    testWidgets('displays the report form', (tester) async {
      await tester.pumpWidget(createTestApp());

      expect(find.text('Report an Item'), findsOneWidget);
      expect(find.text('What would you like to report?'), findsOneWidget);
      expect(find.text('Lost Item'), findsOneWidget);
      expect(find.text('Found Item'), findsOneWidget);
      expect(find.text('Item Information'), findsOneWidget);
      expect(find.text('Submit Report'), findsOneWidget);
    });

    testWidgets('does not display handover field for Lost items', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      expect(find.text('Handover Point'), findsNothing);
    });

    testWidgets('displays handover field for Found items', (tester) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.text('Found Item'));
      await tester.pumpAndSettle();

      expect(find.text('Handover Point'), findsOneWidget);
    });

    testWidgets('hides handover field when switching back to Lost', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.text('Found Item'));
      await tester.pumpAndSettle();

      expect(find.text('Handover Point'), findsOneWidget);

      await tester.tap(find.text('Lost Item'));
      await tester.pumpAndSettle();

      expect(find.text('Handover Point'), findsNothing);
    });

    testWidgets('shows validation errors when submitting an empty form', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.ensureVisible(find.text('Submit Report'));
      await tester.tap(find.text('Submit Report'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter the item name.'), findsOneWidget);
      expect(find.text('Please describe the item.'), findsOneWidget);
      expect(find.text('Please select a category.'), findsOneWidget);
      expect(find.text('Please enter the location.'), findsOneWidget);
    });

    testWidgets('does not require a handover point for Lost items', (
      tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.ensureVisible(find.text('Submit Report'));
      await tester.tap(find.text('Submit Report'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a handover point.'), findsNothing);
    });

    testWidgets('rejects a valid Found report without a photo', (tester) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.text('Found Item'));
      await tester.pumpAndSettle();

      final textFields = find.byType(TextFormField);

      await tester.ensureVisible(textFields.at(0));
      await tester.enterText(textFields.at(0), 'Calculator');

      await tester.ensureVisible(textFields.at(1));
      await tester.enterText(
        textFields.at(1),
        'Black scientific calculator with a blue cover.',
      );

      await tester.ensureVisible(textFields.at(2));
      await tester.enterText(textFields.at(2), 'Computer Science Building');

      await tester.ensureVisible(textFields.at(3));
      await tester.enterText(textFields.at(3), 'Main Security Office');

      final categoryDropdown = find.byType(
        DropdownButtonFormField<ItemCategory>,
      );

      tester.testTextInput.hide();
      await tester.pumpAndSettle();

      await tester.ensureVisible(categoryDropdown);
      await tester.pumpAndSettle();
      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Calculators').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Submit Report'));
      await tester.tap(find.text('Submit Report'));
      await tester.pumpAndSettle();

      expect(find.text('Please correct the errors in the form.'), findsNothing);
      expect(find.text('Please enter the item name.'), findsNothing);
      expect(find.text('Please describe the item.'), findsNothing);
      expect(find.text('Please select a category.'), findsNothing);
      expect(find.text('Please enter the location.'), findsNothing);

      expect(
        find.text('Please add a photo before continuing.'),
        findsOneWidget,
      );
    });

    testWidgets('submits a Lost report to the shared Feed repository', (
      tester,
    ) async {
      final repository = InMemoryItemRepository();

      final container = ProviderContainer(
        overrides: [
          currentUserProvider.overrideWithValue(
            const AuthUser(
              id: 'test-user-1',
              fullName: 'Test Student',
              email: 'test@aau.edu.et',
            ),
          ),
          itemRepositoryProvider.overrideWith((ref) => repository),
        ],
      );

      addTearDown(container.dispose);

      await tester.pumpWidget(createTestApp(container: container));

      // Load the initial Feed data.
      await container.read(itemsProvider.future);

      await fillLostReport(tester);

      await tester.ensureVisible(find.text('Submit Report'));
      await tester.tap(find.text('Submit Report'));
      await tester.pumpAndSettle();

      expect(
        find.text('Your item report has been submitted successfully.'),
        findsOneWidget,
      );

      // Verify the report was persisted in the shared repository.
      final savedItems = await repository.getAll();

      expect(savedItems.length, 6);

      final submittedItem = savedItems.first;

      expect(submittedItem.id, 'item-100');
      expect(submittedItem.title, 'Lost calculator');
      expect(
        submittedItem.description,
        'Black scientific calculator with a blue cover.',
      );
      expect(submittedItem.category, ItemCategory.calculators);
      expect(submittedItem.location, 'Computer Science Building');
      expect(submittedItem.type, ReportType.lost);
      expect(submittedItem.reporterId, 'test-user-1');
      expect(submittedItem.handoverPoint, isNull);
      expect(submittedItem.imageUrl, isNull);

      // Verify that the Feed provider reflects the submitted report.
      final feedItems = await container.read(itemsProvider.future);

      expect(feedItems.first.id, 'item-100');
      expect(feedItems.first.title, 'Lost calculator');

      // Verify that the form was reset after submission.
      expect(find.text('Lost calculator'), findsNothing);
    });

    testWidgets('prevents submission when no user is authenticated', (
      tester,
    ) async {
      final repository = InMemoryItemRepository();

      final container = ProviderContainer(
        overrides: [
          currentUserProvider.overrideWithValue(null),
          itemRepositoryProvider.overrideWith((ref) => repository),
        ],
      );

      addTearDown(container.dispose);

      await tester.pumpWidget(createTestApp(container: container));

      await container.read(itemsProvider.future);

      await fillLostReport(tester);

      await tester.ensureVisible(find.text('Submit Report'));
      await tester.tap(find.text('Submit Report'));
      await tester.pumpAndSettle();

      expect(
        find.text('Please sign in before submitting a report.'),
        findsOneWidget,
      );

      // No report should have been added.
      final savedItems = await repository.getAll();

      expect(savedItems.length, 5);
      expect(savedItems.any((item) => item.title == 'Lost calculator'), false);
    });
  });
}
