import 'package:firstproject/views/calculator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('CalculatorPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CalculatorPage()));

    expect(find.text('Kalkulator'), findsOneWidget);
    expect(find.text('Kobieta'), findsOneWidget);
    expect(find.text('Mężczyzna'), findsOneWidget);
    expect(find.text('Waga: 60 kg'), findsOneWidget);
    expect(find.text('Wzrost: 150 cm'), findsOneWidget);
    expect(find.text('Wiek: 18'), findsOneWidget);
    expect(find.byType(Slider), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  group('CalculatorPage Unit Tests', () {
    test('calculateBMI should return correct result for given weight and height', () {
      final result = calculateBMI(70.0, 175.0);

      expect(result[0], closeTo(22.86, 0.01)); // Close enough to 22.86
      expect(result[1], 'waga prawidłowa');
    });

    test('calculate should return correct macronutrients for given parameters', () {
      final result = calculate(70.0, 175.0, 25.0, Gender.male);

      expect(result[0], closeTo(1675, 0.9));
      expect(result[1], closeTo(140.0, 0.9));
      expect(result[2], closeTo(42.0, 0.9));
      expect(result[3], closeTo(185.0, 0.9));
    });
  });



}
