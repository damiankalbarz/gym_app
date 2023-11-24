import 'package:firstproject/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/views/calculator_view.dart';

void main() {
  group('CalculatorPage Tests', () {
    testWidgets('Initial UI is rendered', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp()); // Zaktualizuj zgodnie ze swoją strukturą aplikacji

      // Verify that initial UI is rendered.
      expect(find.text('Kalkulator'), findsOneWidget);
      expect(find.text('Kobieta'), findsOneWidget);
      expect(find.text('Mężczyzna'), findsOneWidget);
      expect(find.text('Waga: 60 kg'), findsOneWidget);
      expect(find.text('Wzrost: 150 cm'), findsOneWidget);
      expect(find.text('Wiek: 18'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('BMI and Macronutrients Calculation', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp()); // Zaktualizuj zgodnie ze swoją strukturą aplikacji

      // Interact with the UI - select gender, adjust sliders, and press the button
      await tester.tap(find.text('Mężczyzna'));
      await tester.pump();
      await tester.drag(find.byType(Slider).first, const Offset(50.0, 0.0));
      await tester.drag(find.byType(Slider).at(1), const Offset(0.0, -50.0));
      await tester.drag(find.byType(Slider).last, const Offset(20.0, 0.0));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the result is displayed correctly.
      expect(find.text('Bmi:'), findsOneWidget);
      expect(find.text('Zapotrzebowanie energetyczne:'), findsOneWidget);
      expect(find.text('Białko:'), findsOneWidget);
      expect(find.text('Tłuszcze:'), findsOneWidget);
      expect(find.text('Węglowodany:'), findsOneWidget);
    });
  });
}
