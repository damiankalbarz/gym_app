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
          mainAxisAlignment: MainAxisAlignment.start,
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
            SizedBox(height: 20),
            Container(
              width: 0.9*MediaQuery.of(context).size.width,
              //height: 0.2*MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: goalController,
                      decoration: InputDecoration(
                        hintText: 'Dodaj nowy cel', hintStyle: TextStyle(fontFamily: 'Bellota-Regular'),
                        labelStyle: TextStyle(fontFamily: 'Bellota-Regular'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16.0),
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
           SizedBox(height: 2),
           Container(
              width: 0.9*MediaQuery.of(context).size.width,
              height: 0.2*MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10.0)),
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(goals[index].name, style: TextStyle(fontFamily: 'Bellota-Regular'),),
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
            SizedBox(height: 20,),
            Center(
              child: Text(
                'TWOJE ZAJĘCIA:',
                style: TextStyle(fontFamily: "Bellota-Regular",fontSize: 22),
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