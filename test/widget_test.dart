import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campus_lost/app.dart';

void main() {
  testWidgets('CampusLost launches on the login screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CampusLostApp()));

    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Login / Register'),
      ),
      findsOneWidget,
    );
  });
}
