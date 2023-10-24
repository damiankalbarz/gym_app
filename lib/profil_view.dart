import 'dart:convert';
import 'dart:typed_data';

import 'package:firstproject/profilPage_bloc.dart';
import 'package:flutter/material.dart';
import 'User.dart';
import 'navigation.dart';
import 'settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


Image imageFromBase64String(String base64String) {
  try {
    Uint8List bytes = base64Decode(base64String);
    //print(bytes);
    //print(base64String);
    Uint8List _byteImage = base64.decode(base64String);
    return Image.memory(_byteImage);
  } catch (e) {
    print('Error loading image: $e');
    return Image.asset('path_to_error_image');
  }
}


class Goal {
  String name;
  bool isChecked;
  Goal({required this.name, this.isChecked = false});
}

class ProfilPage extends StatefulWidget {
  final ProfilPageBloc bloc = ProfilPageBloc();
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _currentIndex = 0;
  List<Goal> goals = [];
  TextEditingController goalController = TextEditingController();
  Map<String, bool> checkedGoals = {};


  _loadGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? goalsData = prefs.getStringList('goals');
    if (goalsData != null) {
      setState(() {
        goals = goalsData.map((goalData) {
          bool isChecked = prefs.getBool(goalData) ?? false;
          checkedGoals[goalData] = isChecked;
          return Goal(name: goalData, isChecked: isChecked);
        }).toList();
      });
    }
  }

  _saveGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> goalsData = goals.map((goal) => goal.name).toList();
    for (var goal in goals) {
      prefs.setBool(goal.name, goal.isChecked);
    }
    prefs.setStringList('goals', goalsData);
  }


  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.bloc.getUser();
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

            StreamBuilder<User>(
              stream: widget.bloc.userStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Kolor tła kontenera
                          borderRadius: BorderRadius.circular(30.0), // Zaokrąglenie brzegów
                        ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: ClipOval( clipBehavior: Clip.antiAlias,
                              child: Image.memory(snapshot.data!.profilePicture.content),
                              //child: imageFromBase64String(snapshot.data!.profilePicture.content),
                          ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text('${snapshot.data!.userName}', style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 18)),
                              Text('${snapshot.data!.fullName}', style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 12)),
                            ],
                          ),

                          Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SettingsView()),
                                  );
                                },
                                icon: Icon(Icons.settings)),
                          ),
                        ],
                      ),
                      ),
                      Text('Witaj ${snapshot.data!.userName}!',
                      style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 32),
                   ),


                  ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Błąd pobierania danych użytkownika'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),


            SizedBox(height: 10),
            Center(
              child: Text(
                'OTO LISTA TWOICH CELÓW!',
                style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),
              ),
            ),


            SizedBox(height: 20),


            Container(
              width: 0.9 * MediaQuery.of(context).size.width,
              //height: 0.2*MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: goalController,
                      decoration: InputDecoration(
                        hintText: 'Dodaj nowy cel',
                        hintStyle: TextStyle(fontFamily: 'Bellota-Regular'),
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
              width: 0.9 * MediaQuery.of(context).size.width,
              height: 0.2 * MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      goals[index].name,
                      style: TextStyle(fontFamily: 'Bellota-Regular'),
                    ),
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

            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'TWOJE ZAJĘCIA:',
                style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),
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
