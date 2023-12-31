import 'package:firstproject/Model/ListClassModel.dart';
import 'package:firstproject/services/classes_api.dart';
import 'package:flutter/material.dart';

import '../Model/PersonalTrainer.dart';
import '../navigation/navigation.dart';

const List<String> daysOfWeek = <String>[
  "Wszystkie",
  "Poniedziałek",
  "Wtorek",
  "Środa",
  "Czwartek",
  "Piątek",
  "Sobota",
  "Niedziela"
];
List<String> fullNameList = <String>['Wszyscy']; //Lista wyboru trenerow
List<String> classesName = <String>['Wszystkie'];

class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

String convertToPolishDay(String englishDay) {
  switch (englishDay) {
    case 'monday':
      return 'Poniedziałek';
    case 'tuesday':
      return 'Wtorek';
    case 'wednesday':
      return 'Środa';
    case 'thursday':
      return 'Czwartek';
    case 'friday':
      return 'Piątek';
    case 'saturday':
      return 'Sobota';
    case 'sunday':
      return 'Niedziela';
    default:
      return 'Invalid day';
  }
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

  void classFiltering(String trainer, String sport, String day, List<ListClassModel> noSortedList) {
    finishList = [];

    if (trainer == 'Wszyscy' && sport == 'Wszystkie' && day == 'Wszystkie') {
      finishList = noSortedList;
    } else if (day == 'Wszystkie' && sport == 'Wszystkie') {
      noSortedList.forEach((element) {
        if (element.Trainer == trainer) {
          finishList.add(element);
        }
      });
    } else if (trainer == 'Wszyscy' && day == 'Wszystkie') {
      noSortedList.forEach((element) {
        if (element.className == sport) {
          finishList.add(element);
        }
      });
    } else if (day == 'Wszystkie') {
      noSortedList.forEach((element) {
        if (element.className == sport && element.Trainer == trainer) {
          finishList.add(element);
        }
      });
    } else if (trainer == 'Wszyscy' && sport == 'Wszystkie') {
      noSortedList.forEach((element) {
        if (element.dayOfWeek == day) {
          finishList.add(element);
        }
      });
    } else if (trainer == 'Wszyscy') {
      noSortedList.forEach((element) {
        if (element.dayOfWeek == day && element.className == sport) {
          finishList.add(element);
        }
      });
    } else if (sport == 'Wszystkie') {
      noSortedList.forEach((element) {
        if (element.dayOfWeek == day && element.Trainer == trainer) {
          finishList.add(element);
        }
      });
    } else {
      noSortedList.forEach((element) {
        if (element.className == sport &&
            element.Trainer == trainer &&
            element.dayOfWeek == day) {
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
    List<PersonalTrainer> fetchedTrainers =
        await ClassesApi().getTrainer(); // Pobierz listę trenerów
    setState(() {
      trainers = fetchedTrainers; // Ustaw pobraną listę trenerów w stanie
      fullNameList = ["Wszyscy"];
      classesName = ["Wszystkie"];
      trainers.forEach((e) {
        fullNameList.add("${e.name} ${e.surname}");
        e.sports.forEach((element) {
          classesName.add(element.className);
        });
      });
      trainers.forEach((element) {
        element.sports.forEach((e) {
          list.add(ListClassModel(
              e.id,
              e.className,
              e.startTime,
              e.endTime,
              convertToPolishDay(e.dayOfWeek),
              ("${element.name} ${element.surname}"),
            e.maxUsers,
            e.usersCount,
          ));
        });
      });
      finishList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.05 * MediaQuery.of(context).size.height,
                ),
                Text(
                  "ZAPIS NA ZAJECIA",
                  style: TextStyle(fontFamily: 'Bellota-Regular', fontSize: 32),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Trenerzy",
                          style: TextStyle(fontSize: 14, fontFamily: "Bellota-Regular"),
                        ),
                        Container(
                          child: DropdownButton<String>(
                            value: dropdownValue2,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.lightBlue,),
                            underline: Container(height: 2, color: Colors.lightBlue,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue2 = value!;
                                classFiltering(dropdownValue2, dropdownValue3, dropdownValue1, list);
                              });
                            },
                            items: fullNameList.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(fontSize: 12, fontFamily: "Bellota-Regular"),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 2),
                    Column(
                      children: [
                        Text(
                          "Zajecia",
                          style: TextStyle(
                              fontSize: 14, fontFamily: "Bellota-Regular"),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue3,
                          icon: Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: TextStyle(color: Colors.lightBlue),
                          underline: Container(
                            height: 2,
                            color: Colors.lightBlue,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue3 = value!;
                              classFiltering(dropdownValue2, dropdownValue3,
                                  dropdownValue1, list);
                            });
                          },
                          items: classesName
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Bellota-Regular"),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Column(
                      children: [
                        Text(
                          "Dzień ",
                          style: TextStyle(
                              fontSize: 14, fontFamily: "Bellota-Regular"),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue1,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.lightBlue),
                          underline: Container(
                            height: 2,
                            color: Colors.lightBlue,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue1 = value!;
                              classFiltering(dropdownValue2, dropdownValue3,
                                  dropdownValue1, list);
                            });
                          },
                          items: daysOfWeek
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Bellota-Regular"),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 0.8 * MediaQuery.of(context).size.height,
                  width: 0.9 * MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: finishList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 2),
                      itemBuilder: (context, index) {
                        return Container(
                            height: 0.12 * MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white12
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${finishList[index].className}  ${finishList[index].usersCount}/${finishList[index].maxUsers}",
                                      style: TextStyle(
                                          fontFamily: "Bellota-Regular",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      " ${finishList[index].Trainer}",
                                      style: TextStyle(
                                          fontFamily: "Bellota-Regular",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "${finishList[index].dayOfWeek} ${finishList[index].startTime} - ${finishList[index].endTime}",
                                      style: TextStyle(
                                          fontFamily: "Bellota-Regular",
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.095 *
                                      MediaQuery.of(context).size.height,
                                  width: 0.095 *
                                      MediaQuery.of(context).size.height,
                                  margin: EdgeInsets.only(right: 5),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white12
                                        : Colors.blue,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text(
                                                  "Potwierdź zapis na zajęcia",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Bellota-Regular",
                                                      fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: <Widget>[
                                                  Center(
                                                    child: Text(
                                                      "${finishList[index].className} -  ${finishList[index].Trainer}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Bellota-Regular",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                        "${finishList[index].dayOfWeek} ${finishList[index].startTime} - ${finishList[index].endTime}"),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextButton(
                                                        child: Text("Anuluj"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text(
                                                          "Potwierdzam",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                        onPressed: () {
                                                          ClassesApi()
                                                              .addClasses(
                                                                  finishList[
                                                                          index]
                                                                      .id);
                                                          Navigator.of(context)
                                                              .pop(); // Zamknij okno dialogowe
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ]);
                                          });
                                    },
                                    child: Icon(
                                      Icons.add_circle_outline, // ikona zapisu
                                      size:
                                          25, // dostosuj rozmiar ikony według preferencji
                                    ),
                                  ),
                                ),
                              ],
                            )
                            //Text("${list[index].Trainer} ${list[index].dayOfWeek} ${list[index].startTime}"),
                            );
                      }),
                ),
                Container(),
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
