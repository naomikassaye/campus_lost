import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/app.dart';
import 'package:campus_lost/features/auth/presentation/login_screen.dart';

void main() {
  testWidgets('CampusLost launches on the login screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CampusLostApp()));

    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
