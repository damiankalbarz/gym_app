import 'package:firstproject/views/profil_view.dart';
import 'package:firstproject/views/widget/SavedClasses_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProfilPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ProfilPage(),
    ));

    expect(find.text('OTO LISTA TWOICH CELÓW!'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('TWOJE ZAJĘCIA:'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.byType(ListTile), findsNothing);
  });
}
