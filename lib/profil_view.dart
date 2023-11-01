import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:firstproject/Model/ProfilPictureDTO.dart';
import 'package:firstproject/profilPage_bloc.dart';
import 'package:flutter/material.dart';
import 'Model/Goal.dart';
import 'Model/User.dart';
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

class ProfilPage extends StatefulWidget {
  final ProfilPageBloc bloc = ProfilPageBloc();

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _currentIndex = 0;
  List<Goal> goals = [];
  TextEditingController goalController = TextEditingController();

  _loadGoals() async {
    List<Goal>? fetchedGoals = await widget.bloc.getGoals();
    setState(() {
      if(fetchedGoals != null){
        goals = fetchedGoals;
      }
    });
  }

  _toggleGoal(int index, bool value) {
    setState(() {
      goals[index].finished = value;
      widget.bloc.toggle(goals[index].id);
      _loadGoals();
    });
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
                stream: widget.bloc.userStream,
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
                                  height: MediaQuery.of(context).size.height * 0.065,
                                  decoration: BoxDecoration(
                                    color: Colors.blue, // Kolor tła kontenera
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
                                  stream: widget.bloc.pictureStream,
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
                            widget.bloc.addGoals(goalController.text);
                            goalController.clear();
                            Future.delayed(const Duration(milliseconds: 100), () {
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
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 1),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: goals[index].finished ? Colors.lightBlueAccent : Colors.blue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                      title: Text(
                        //goals[index].name,
                        goals[index].content,
                        style: TextStyle(fontFamily: 'Bellota-Regular',decoration: goals[index].finished
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
                      ),
                      leading: Checkbox(
                        value: goals[index].finished,
                        onChanged: (value) {
                          setState(() {
                            goals[index].finished = value!;
                            print("x${goals[index].finished}x");
                            widget.bloc.toggle(goals[index].id);
                            Future.delayed(const Duration(milliseconds: 100), () {
                              _loadGoals();
                            });
                          });
                        },
                      ),

                        trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.bloc.deleteGoal(goals[index].id);
                            Future.delayed(const Duration(milliseconds: 100), () {
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
