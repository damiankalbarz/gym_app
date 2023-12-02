import 'package:firstproject/views/calculator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/*
void main() {
  testWidgets('CalculatorPage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: CalculatorPage()));

    // Verify if the UI elements are present
    expect(find.text('Kalkulator'), findsOneWidget);
    expect(find.text('Kobieta'), findsOneWidget);
    expect(find.text('Mężczyzna'), findsOneWidget);
    expect(find.text('Waga: 60 kg'), findsOneWidget);
    expect(find.text('Wzrost: 150 cm'), findsOneWidget);
    expect(find.text('Wiek: 18'), findsOneWidget);
    expect(find.byType(Slider), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  test('Calculate BMI Test', () {
    final calculatorPage = CalculatorPage();
    final result = calculatorPage.calculateBMI(60.0, 150.0);

    expect(result[0], closeTo(26.67, 0.01)); // Sprawdzamy, czy BMI jest prawidłowe
    expect(result[1], 'nadwaga'); // Sprawdzamy, czy ocena BMI jest prawidłowa
  });

  test('Calculate Macronutrients Test - Male', () {
    final calculatorPage = CalculatorPage();
    final result = calculatorPage.calculate(70.0, 180.0, 25.0, Gender.male);

    expect(result[0], closeTo(2255.0, 0.01)); // Sprawdzamy, czy zapotrzebowanie energetyczne jest prawidłowe
    expect(result[1], closeTo(140.0, 0.01)); // Sprawdzamy, czy ilość białka jest prawidłowa
    expect(result[2], closeTo(56.75, 0.01)); // Sprawdzamy, czy ilość tłuszczu jest prawidłowa
    expect(result[3], closeTo(278.25, 0.01)); // Sprawdzamy, czy ilość węglowodanów jest prawidłowa
  });

  test('Calculate Macronutrients Test - Female', () {
    final calculatorPage = CalculatorPage();
    final result = calculatorPage.calculate(60.0, 160.0, 30.0, Gender.female);

    expect(result[0], closeTo(1611.0, 0.01)); // Sprawdzamy, czy zapotrzebowanie energetyczne jest prawidłowe
    expect(result[1], closeTo(120.0, 0.01)); // Sprawdzamy, czy ilość białka jest prawidłowa
    expect(result[2], closeTo(40.5, 0.01)); // Sprawdzamy, czy ilość tłuszczu jest prawidłowa
    expect(result[3], closeTo(162.75, 0.01)); // Sprawdzamy, czy ilość węglowodanów jest prawidłowa
  });
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 // Zaktualizuj ścieżkę do pliku calculator_page.dart

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
  /*
  test('Calculate BMI Test', () {
    final calculatorPage = CalculatorPage();
    final result = calculatorPage.calculateBMI(60.0, 150.0);

    expect(result[0], closeTo(26.67, 0.01));
    expect(result[1], 'nadwaga');
  });

  test('Calculate Macronutrients Test - Male', () {
    final calculatorPage = CalculatorPage();
    final result = calculatorPage.calculate(70.0, 180.0, 25.0, Gender.male);

    expect(result[0], closeTo(2255.0, 0.01));
    expect(result[1], closeTo(140.0, 0.01));
    expect(result[2], closeTo(56.75, 0.01));
    expect(result[3], closeTo(278.25, 0.01));
  });

  test('Calculate Macronutrients Test - Female', () {
    final calculatorPage = CalculatorPage();
    final result = calculatorPage.calculate(60.0, 160.0, 30.0, Gender.female);

    expect(result[0], closeTo(1611.0, 0.01));
    expect(result[1], closeTo(120.0, 0.01));
    expect(result[2], closeTo(40.5, 0.01));
    expect(result[3], closeTo(162.75, 0.01));
  });

   */
}
