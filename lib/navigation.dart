import 'package:firstproject/classes_view.dart';
import 'package:firstproject/profil_view.dart';
import 'package:firstproject/statistic_view.dart';
import 'package:firstproject/tiket_view.dart';
import 'package:flutter/material.dart';

import 'calculator_view.dart';

class BottomNavigationWidget extends StatelessWidget {
  final ValueChanged<int> onTabSelected;
  final int currentIndex;

  BottomNavigationWidget({
    required this.onTabSelected,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              onTabSelected(0);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilPage(),
                ),
              );
            }, // Indeks 0 dla przycisku "Home"
            color: currentIndex == 0 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              onTabSelected(1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalculatorPage(),
                ),
              );
            }, // Indeks 1 dla przycisku "Search"
            color: currentIndex == 1 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.credit_card),
            onPressed: () {
              onTabSelected(4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QrCodeScreen(qrData: "sadsadsa"),
                ),
              );
            }, // Indeks 2 dla przycisku "Add"
            color: currentIndex == 2 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              onTabSelected(4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatisticPage(),
                ),
              );
            }, // Indeks 3 dla przycisku "Favorite"
            color: currentIndex == 3 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              onTabSelected(4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Classes(),
                ),
              );
            },
            color: currentIndex == 4 ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }
}
