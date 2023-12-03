import 'package:firstproject/views/profil_view.dart';
import 'package:firstproject/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firstproject/views/login_view.dart';

void main() {
  testWidgets('LoginPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    expect(find.text('Adres email'), findsOneWidget);
    expect(find.text('Hasło'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Zaloguj się'), findsOneWidget);
    expect(find.text('Nie masz jeszcze konta? Zarejestruj się'), findsOneWidget);


    await tester.tap(find.text('Nie masz jeszcze konta? Zarejestruj się'));
    await tester.pumpAndSettle();

  });
}
