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



    test('calculateBMI should handle overweight case', () {
      final result = calculateBMI(90.0, 180.0);

      expect(result[0], closeTo(27.78, 0.01));
      expect(result[1], 'nadwaga');
    });



    test('calculateBMI should handle normal weight rating for BMI between 18.5 and 24.99', () {
      final result = calculateBMI(70.0, 175.0);

      expect(result[0], closeTo(22.86, 0.01));
      expect(result[1], 'waga prawidłowa');
    });



    test('calculateBMI should handle obesity rating I for BMI between 30 and 34.99', () {
      final result = calculateBMI(100.0, 180.0);

      expect(result[0], closeTo(30.86, 0.01));
      expect(result[1], 'I stopień otyłości');
    });

    test('calculateBMI should handle obesity rating II for BMI between 35 and 39.99', () {
      final result = calculateBMI(120.0, 180.0);

      expect(result[0], closeTo(37.04, 0.01));
      expect(result[1], 'II stopień otyłości');
    });

    test('calculateBMI should handle extreme obesity rating for BMI greater than 40', () {
      final result = calculateBMI(150.0, 180.0);

      expect(result[0], closeTo(46.30, 0.01));
      expect(result[1], 'otyłość skrajna');
    });

    // Additional test cases
    test('calculateBMI should handle extreme underweight rating for BMI less than 16', () {
      final result = calculateBMI(30.0, 160.0);

      expect(result[0], closeTo(11.72, 0.01));
      expect(result[1], 'wygłodzenie');
    });

    test('calculateBMI should return correct result for normal weight and height', () {
      final result = calculateBMI(70.0, 175.0);

      expect(result[0], closeTo(22.86, 0.01)); // Close enough to 22.86
      expect(result[1], 'waga prawidłowa');
    });


    test('calculateBMI should handle overweight case', () {
      final result = calculateBMI(90.0, 180.0);

      expect(result[0], closeTo(27.78, 0.01));
      expect(result[1], 'nadwaga');
    });

    test('calculateBMI should handle extreme underweight case', () {
      final result = calculateBMI(30.0, 160.0);

      expect(result[0], closeTo(11.72, 0.01));
      expect(result[1], 'wygłodzenie');
    });

    test('calculateBMI should handle extreme overweight case', () {
      final result = calculateBMI(150.0, 180.0);

      expect(result[0], closeTo(46.30, 0.01));
      expect(result[1], 'otyłość skrajna');
    });












  });



}
