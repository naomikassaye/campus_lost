import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';
import 'package:campus_lost/features/report_item/presentation/report_item_screen.dart';

void main() {
  Widget createTestApp() {
    return const ProviderScope(child: MaterialApp(home: ReportItemScreen()));
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

      await tester.ensureVisible(categoryDropdown);
      await tester.pumpAndSettle();

      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle();

      expect(find.text('Calculators').last, findsOneWidget);

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

      expect(
        find.text(
          'Your report is valid. Submission will be available '
          'once the repository is integrated.',
        ),
        findsNothing,
      );
    });
  });
}
