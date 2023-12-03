import 'package:firstproject/views/gymPass_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GymPassScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: GymPassScreen(),
    ));

    expect(find.text('Twój karnet'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the UI is updated after the button tap.
    expect(find.text('Przedłuż karnet'), findsOneWidget);


  });
}
