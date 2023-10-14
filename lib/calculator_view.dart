import 'package:flutter/material.dart';

import 'navigation.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

enum Gender { female, male } // Enumeracja reprezentująca wybór płci

class _CalculatorPageState extends State<CalculatorPage> {
  Gender? selectedGender = Gender.male;
  double weight = 60.0; // Domyślna waga
  double height = 150.0; // Domyślny wzrost
  double bmi = 0;
  String ratingBmi = '';
  double age = 18;
  bool istextVisable = false;
  double macronutrients = 0;
  double protein = 0;
  double carbohydrates = 0;
  double fats = 0;
  int _currentIndex = 1;
  late List<double> list;

  List<dynamic> calculateBMI(double weight, double height) {
    bmi = weight / ((height * height) / 10000);
    if (bmi < 16)
      ratingBmi = 'wygłodzenie';
    else if (bmi < 17)
      ratingBmi = "wychudzenie";
    else if (bmi < 18.49)
      ratingBmi = "niedowaga";
    else if (bmi < 25)
      ratingBmi = "waga prawidłowa";
    else if (bmi < 30)
      ratingBmi = "nadwaga";
    else if (bmi < 35)
      ratingBmi = "I stopień otyłości";
    else if (bmi < 40)
      ratingBmi = "II stopień otyłości";
    else
      ratingBmi = "otyłość skrajna";
    return [bmi, ratingBmi];
  }

  List<double> calculate(
      double weight, double height, double age, Gender gender) {
    if (selectedGender == Gender.male)
      macronutrients = weight * 9.99 + ((6.25 * height) - (4.92 * age)) + 5;
    else
      macronutrients = weight * 9.99 + ((6.25 * height) - (4.92 * age)) - 161;
    protein = 2 * weight;
    fats = 0.225 * macronutrients / 9;
    carbohydrates = (macronutrients - (protein * 4 + fats * 9)) / 4;
    return [macronutrients, protein, fats, carbohydrates];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Kalkulator',
                style: TextStyle(fontSize: 28, fontFamily: "Bellota-Regular")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio<Gender>(
                  value: Gender.female,
                  groupValue: selectedGender,
                  onChanged: (Gender? value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text(
                  'Kobieta',
                  style: TextStyle(fontFamily: "Bellota-Regular"),
                ),
                SizedBox(width: 20), // Odstęp między przyciskami
                Radio<Gender>(
                  value: Gender.male,
                  groupValue: selectedGender,
                  onChanged: (Gender? value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text('Mężczyzna',
                    style: TextStyle(fontFamily: "Bellota-Regular")),
              ],
            ),
            Text(
              'Waga: ${weight.toStringAsFixed(0)} kg',
              style: TextStyle(fontFamily: "Bellota-Regular"),
            ),
            Slider(
              value: weight,
              onChanged: (newValue) {
                setState(() {
                  weight = newValue;
                });
              },
              min: 10.0,
              max: 200.0,
              divisions: 200,
            ),
            Text(
              'Wzrost: ${height.toStringAsFixed(0)} cm',
              style: TextStyle(fontFamily: "Bellota-Regular"),
            ),
            Slider(
              value: height,
              onChanged: (newValue) {
                setState(() {
                  height = newValue;
                });
              },
              min: 100,
              max: 250,
              divisions: 250,
            ),
            Text(
              'Wiek: ${age.toStringAsFixed(0)}',
              style: TextStyle(fontFamily: "Bellota-Regular"),
            ),
            Slider(
              value: age,
              onChanged: (newValue) {
                setState(() {
                  age = newValue;
                });
              },
              min: 1,
              max: 120,
              divisions: 120,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    list = calculate(weight, height, age, selectedGender!);
                    istextVisable = true;
                  });
                },
                child: Text('Oblicz BMI i Makroskładniki',
                    style: TextStyle(fontFamily: 'Bellota-Regular'))),
            SizedBox(height: 30),
            if (istextVisable)
              Container(
                  padding: EdgeInsets.all(7.0),
                  width: 0.9 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    ' Bmi: ${calculateBMI(weight as double, height as double).first.toStringAsFixed(2)} - ${calculateBMI(weight as double, height as double).last}\n'
                    ' Zapotrzebowanie energetyczne: ${list[0].toStringAsFixed(0)} kcal\n'
                    ' Białko: ${list[1].toStringAsFixed(0)} g\n'
                    ' Tłuszcze: ${list[2].toStringAsFixed(0)} g\n'
                    ' Węglowodany: ${list[3].toStringAsFixed(0)} g',
                    style: TextStyle(
                      fontSize: 16, // Rozmiar czcionki
                      fontStyle: FontStyle.italic, // Styl kursywy
                      fontWeight: FontWeight.bold, // Pogrubienie tekstu
                      fontFamily:
                          "Bellota-Regular", // Rozstawienie między literami
                      // Możesz także ustawić więcej właściwości stylu, takie jak fontFamily, decoration itp.
                    ),
                  ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
