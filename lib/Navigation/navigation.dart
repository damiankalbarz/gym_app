import 'package:firstproject/views/classes_view.dart';
import 'package:firstproject/views/profil_view.dart';
import 'package:firstproject/views/statistic_view.dart';
import 'package:firstproject/views/gymPass_view.dart';
import 'package:flutter/material.dart';

import '../views/calculator_view.dart';

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
            },
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
            },
            color: currentIndex == 1 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.credit_card),
            onPressed: () {
              onTabSelected(4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GymPassScreen(),
                ),
              );
            },
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
            },
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
