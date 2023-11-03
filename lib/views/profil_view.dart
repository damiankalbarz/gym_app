import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';

import 'package:firstproject/Model/ListClassModel.dart';
import 'package:firstproject/Model/ProfilPictureDTO.dart';
import 'package:firstproject/views/SavedClasses_widget.dart';
import 'package:firstproject/Bloc/profilPage_bloc.dart';
import 'package:firstproject/services/classes_api.dart';
import 'package:firstproject/services/goals_api.dart';
import 'package:firstproject/services/user_api.dart';
import 'package:flutter/material.dart';
import '../Model/Goal.dart';
import '../Model/User.dart';
import '../navigation.dart';
import 'settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _currentIndex = 0;
  List<Goal> goals = [];
  TextEditingController goalController = TextEditingController();
  final UserApi api = UserApi();




  _loadGoals() async {
    List<Goal>? fetchedGoals = await GoalsApi().getGoals();
    setState(() {
      if (fetchedGoals != null) {
        goals = fetchedGoals;
      }
    });
  }

  _toggleGoal(int index, bool value) {
    setState(() {
      goals[index].finished = value;
      GoalsApi().toggle(goals[index].id);
      _loadGoals();
    });
  }

  @override
  void dispose() {
    //widget.bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    api.getUser();
    _loadGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              /*Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsView()),
                    );
                  },
                  icon: Icon(Icons.settings)),
            ),*/
              StreamBuilder<User>(
                stream: api.userStream,
                builder: (context, snapshot) {
                  final isDarkMode =
                      Theme.of(context).brightness == Brightness.dark;
                  final borderColor = isDarkMode ? Colors.white : Colors.black;
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10,
                                // dowolna wartość, aby przesunąć kontener w dół
                                left: 10,
                                right: 0,
                                //child: Align(
                                //alignment: AlignmentDirectional.center,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.black26
                                        : Colors.blue, // Kolor tła kontenera
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        color: borderColor,
                                        width: 2), // Zaokrąglenie brzegów
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.22,
                                      ),
                                      Column(
                                        children: [
                                          Text('${snapshot.data!.userName}',
                                              style: TextStyle(
                                                  fontFamily: "Bellota-Regular",
                                                  fontSize: 15)),
                                          Text('${snapshot.data!.fullName}',
                                              style: TextStyle(
                                                  fontFamily: "Bellota-Regular",
                                                  fontSize: 10)),
                                        ],
                                      ),
                                      Spacer(),
                                      Container(
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SettingsView()),
                                              );
                                            },
                                            icon: Icon(Icons.settings)),
                                      ),
                                    ],
                                  ),
                                  //),
                                ),
                              ),
                              Positioned(
                                child: StreamBuilder<ProfilePictureDTO>(
                                  stream: api.pictureStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: borderColor,
                                            // dostosuj kolor obramowania
                                            width: 2,
                                          ),
                                        ),
                                        // dostosuj szerokość obramowania
                                        child: ClipOval(
                                          child: Image.memory(
                                            snapshot.data!.content,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            fit: BoxFit
                                                .cover, // dostosuj tryb dopasowania
                                          ),
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Text(
                            'Witaj ${snapshot.data!.userName}!',
                            style: TextStyle(
                                fontFamily: "Bellota-Regular", fontSize: 32),
                          ),
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
              SizedBox(height: 0),
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white12
                        : Colors.blue,
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
                            GoalsApi().addGoals(goalController.text);
                            goalController.clear();
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              _loadGoals();
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.185,
                ),
                child: Container(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  //height: 0.2 * MediaQuery.of(context).size.height,
                  /*decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0)),*/
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: goals.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 1),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white12
                              : (goals[index].finished
                              ? Colors.lightBlueAccent
                              : Colors.blue),
                          /*goals[index].finished
                              ? Colors.lightBlueAccent
                              : Colors.blue,*/
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          title: Text(
                            //goals[index].name,
                            goals[index].content,
                            style: TextStyle(
                                fontFamily: 'Bellota-Regular',
                                decoration: goals[index].finished
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          leading: Checkbox(
                            value: goals[index].finished,
                            onChanged: (value) {
                              setState(() {
                                goals[index].finished = value!;
                                print("x${goals[index].finished}x");
                                GoalsApi().toggle(goals[index].id);
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  _loadGoals();
                                });
                              });
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                GoalsApi().deleteGoal(goals[index].id);
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  _loadGoals();
                                });
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
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
              SavedClassesWidget(),
            ],
          ),
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