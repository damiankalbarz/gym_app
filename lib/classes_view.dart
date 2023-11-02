import 'package:firstproject/Model/ListClassModel.dart';
import 'package:flutter/material.dart';

import 'Model/PersonalTrainer.dart';
import 'classes_bloc.dart';
import 'navigation.dart';
import 'dart:convert';
import 'dart:core';

const List<String> daysOfWeek = <String>[
  "Wszytkie",
  "Poniedziałek",
  "Wtorek",
  "Środa",
  "Czwartek",
  "Piątek",
  "Sobota",
  "Niedziela"
];
List<String> fullNameList = <String>["Wszyscy"]; //Lista wyboru trenerow
List<String> classesName = <String>["Wszystkie"];

class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  bool zapisano = false;
  int _currentIndex = 4;
  List<PersonalTrainer> trainers = [];
  List<ListClassModel> finishList = <ListClassModel>[];
  List<ListClassModel> list = <ListClassModel>[];

  String dropdownValue1 = daysOfWeek.first;
  String dropdownValue2 = fullNameList.first;
  String dropdownValue3 = classesName.first;

  void sortowanie(String trainer, String sport, String day, List<ListClassModel> list) {
    finishList=[];
    if (trainer == 'Wszyscy' && sport == 'Wszystkie' && day == 'Wszystkie') {
      finishList = list;
    } else if (day == 'Wszystkie' && sport == 'Wszystkie') {
      list.forEach((element) {
        if(element.Trainer==trainer){
          finishList.add(element);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Wywołaj funkcję pobierającą dane
  }

  void fetchData() async {
    List<PersonalTrainer> fetchedTrainers = await getTrainer(); // Pobierz listę trenerów
    setState(() {
      trainers = fetchedTrainers; // Ustaw pobraną listę trenerów w stanie
      fullNameList = ["Wszyscy"];
      classesName = ["Wszystkie"];
      trainers.forEach((e) {
        fullNameList.add("${e.name} ${e.surname}");
        e.sports.forEach((element) {
          classesName.add(element.className);
        });
        classesName.toSet().toList();
        trainers.forEach((element) {
          element.sports.forEach((e) {
            String formattedTimeStart = e.startTime.substring(0,16);
            String formattedTimeEnd = e.endTime.substring(11,16);
            list.add(ListClassModel(e.id, e.className, formattedTimeStart, formattedTimeEnd, e.dayOfWeek, ("${element.name} ${element.surname}")));
          });
        });
      });
      print(fullNameList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
        child: Center(
          child:
                Container(
                  height: 0.3 * MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ZAPIS NA ZAJECIA",
                        style: TextStyle(
                            fontFamily: 'Bellota-regular', fontSize: 32),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text("Trenerzy"),
                              DropdownButton<String>(
                                value: dropdownValue2,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue2 = value!;
                                    sortowanie(dropdownValue1, dropdownValue3, dropdownValue2, list);
                                  });
                                },
                                items: fullNameList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text("Zajecia"),
                              DropdownButton<String>(
                                value: dropdownValue3,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue3 = value!;
                                  });
                                },
                                items: classesName
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text("Dzień tygodnia"),
                              DropdownButton<String>(
                                value: dropdownValue1,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue1 = value!;
                                  });
                                },
                                items: daysOfWeek.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 0.3 * MediaQuery.of(context).size.height,
                        width: 0.9 * MediaQuery.of(context).size.width,
                        child:  ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: list.length,
                            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 2),
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 0.1 * MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 5,),
                                    Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        Text("${list[index].className} - ${list[index].Trainer}", style: TextStyle(fontFamily: "Bellota-Regular",fontWeight: FontWeight.w600, fontSize: 16),),
                                        Text("${list[index].dayOfWeek} ${list[index].startTime} - ${list[index].endTime}",  style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),),
                                      ],
                                    ),

                                    Container(
                                      height: 0.095 * MediaQuery.of(context).size.height,
                                      width: 0.095 * MediaQuery.of(context).size.height,
                                      margin: EdgeInsets.only(right: 5),
                                      child: ElevatedButton(onPressed: (){},
                                      child: Text("Zapisz się",  style: TextStyle(fontFamily: "Bellota-Regular",fontWeight: FontWeight.w400, fontSize: 13),),
                                    ),
                                    ),


                                  ],
                                )
                                //Text("${list[index].Trainer} ${list[index].dayOfWeek} ${list[index].startTime}"),
                              );}
                        ),
                      ),
                      Container(),
                    ],
                  ),
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
