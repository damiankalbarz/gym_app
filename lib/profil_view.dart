import 'package:flutter/material.dart';
import 'navigation.dart';
import 'settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Goal {
  String name;
  bool isChecked;

  Goal({required this.name, this.isChecked = false});
}

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _currentIndex = 0;
  List<Goal> goals = [];
  TextEditingController goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  _loadGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? goalsData = prefs.getStringList('goals');
    if (goalsData != null) {
      setState(() {
        goals = goalsData
            .map((goalData) => Goal(name: goalData, isChecked: false))
            .toList();
      });
    }
  }

  _saveGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> goalsData = goals.map((goal) => goal.name).toList();
    prefs.setStringList('goals', goalsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
             Align(  alignment: Alignment.topRight,
               child: IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsView()),
              );
            },
                icon: Icon(Icons.settings)),
             ),
            Center(
              child: Text(
                'Witaj Damian!',
                style: TextStyle(fontFamily: "Bellota-Regular" ,fontSize: 32),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'OTO LISTA TWOICH CELÓW!',
                style: TextStyle(fontFamily: "Bellota-Regular",fontSize: 22),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: goalController,
                      decoration: InputDecoration(
                        hintText: 'Dodaj nowy cel',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        String goalName = goalController.text;
                        if (goalName.isNotEmpty) {
                          goals.add(Goal(name: goalName));
                          goalController.clear();
                          _saveGoals(); // Zapisz cele po dodaniu
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(goals[index].name),
                    leading: Checkbox(
                      value: goals[index].isChecked,
                      onChanged: (value) {
                        setState(() {
                          goals[index].isChecked = value!;
                          _saveGoals(); // Zapisz cele po zmianie
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          goals.removeAt(index);
                          _saveGoals(); // Zapisz cele po usunięciu
                        });
                      },
                    ),
                  );
                },
              ),
            ),
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
