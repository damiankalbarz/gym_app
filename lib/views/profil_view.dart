import 'dart:async';

import 'package:firstproject/views/widget/SavedClasses_widget.dart';
import 'package:firstproject/services/goals_api.dart';
import 'package:firstproject/services/user_api.dart';
import 'package:firstproject/views/widget/welcome_widget.dart';
import 'package:flutter/material.dart';
import '../Model/Goal.dart';
import '../navigation.dart';



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
      body:
      Container( child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              WelcomeWidget(),
              SizedBox(height: 0),
              const Center(
                child: Text(
                  'OTO LISTA TWOICH CELÓW!',
                  style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
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
                        decoration: const InputDecoration(
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
                            Future.delayed(const Duration(milliseconds: 150),
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
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: goals.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 1),
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white12
                              : (goals[index].finished
                              ? Colors.lightBlueAccent
                              : Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          title: Text(
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
                                GoalsApi().toggle(goals[index].id);
                                Future.delayed(
                                    const Duration(milliseconds: 150), () {
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
                                    const Duration(milliseconds: 150), () {
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
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Center(
                child: Text(
                  'TWOJE ZAJĘCIA:',
                  style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SavedClassesWidget(),
            ],
          ),
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
