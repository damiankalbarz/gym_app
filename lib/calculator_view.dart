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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Kalkulator',style: TextStyle(fontSize: 28)
            ),

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
                Text('Kobieta'),
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
                Text('Mężczyzna'),
              ],
            ),
            Text('Waga: ${weight.toStringAsFixed(0)} kg'),
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
            Text('Wzrost: ${height.toStringAsFixed(0)} cm'),
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
            Text('Wiek: ${age.toStringAsFixed(0)}'),
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
            ElevatedButton(onPressed: (){
              setState(() {
                bmi = weight / ((height * height)/10000);
                if(selectedGender == Gender.male)
                  macronutrients = weight * 9.99 + ((6.25 * height)-(4.92*age))+5;
                else
                  macronutrients = weight * 9.99 + ((6.25 * height)-(4.92*age))-161;

                protein = 2 * weight;
                fats = 0.225 * macronutrients/9;
                carbohydrates = (macronutrients - (protein * 4 + fats * 9))/4;
                istextVisable = true;

                if(bmi<16) ratingBmi = 'wygłodzenie';
                else if(bmi<17) ratingBmi = "wychudzenie";
                else if(bmi<18.49) ratingBmi = "niedowaga";
                else if(bmi<25) ratingBmi = "waga prawidłowa";
                else if(bmi<30) ratingBmi = "nadwaga";
                else if(bmi<35) ratingBmi = "I stopień otyłości";
                else if(bmi<40) ratingBmi = "II stopień otyłości";
                else ratingBmi = "otyłość skrajna";
              });
            }, child: Text('Oblicz BMI i Makroskładniki')
            ),
            if(istextVisable)
              Padding(
                  padding: EdgeInsets.all(16.0),
                child: Text(
                  ' Bmi: ${bmi.toStringAsFixed(2)} - ${ratingBmi}\n'
                      ' Twoje zapotrzebowanie energetyczne wynosi: ${macronutrients.toStringAsFixed(0)} kcal\n'
                      ' Białko: ${protein.toStringAsFixed(0)} g\n'
                      ' Tłuszcze: ${fats.toStringAsFixed(0)} g\n'
                      ' Węglowodany: ${carbohydrates.toStringAsFixed(0)} g',
                  style: TextStyle(
                    fontSize: 16, // Rozmiar czcionki
                    fontStyle: FontStyle.italic, // Styl kursywy
                    fontWeight: FontWeight.bold, // Pogrubienie tekstu
                    letterSpacing: 1.0, // Rozstawienie między literami
                    // Możesz także ustawić więcej właściwości stylu, takie jak fontFamily, decoration itp.
                  ),
                )
              )

            /*
              Text(' Bmi: ${bmi.toStringAsFixed(2)} - ${ratingBmi}  \n Twoje zapotrzebowanie energetyczne wynosi: ${macronutrients.toStringAsFixed(0)} kcal \n '
                  'Białko: ${protein.toStringAsFixed(0)} g  \n Tłuszcze: ${fats.toStringAsFixed(0)} g \n Węglowodowany: ${carbohydrates.toStringAsFixed(0)} g',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),*/

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
