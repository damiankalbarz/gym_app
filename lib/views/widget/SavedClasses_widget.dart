import 'package:firstproject/services/classes_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/ListClassModel.dart';

class SavedClassesWidget extends StatefulWidget {
  _SavedClassesWidgetState createState() => _SavedClassesWidgetState();
}

class _SavedClassesWidgetState extends State<SavedClassesWidget> {
  List<ListClassModel> classes = [];

  _loadClasses() async {
    classes = await ClassesApi().getClasses();
  }

  void initState() {
    super.initState();
    _loadClasses();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
        shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: classes.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 2),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white12
                      : Colors.blue,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${classes[index].className}",
                          style: TextStyle(
                              fontFamily: "Bellota-Regular",
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        Text(
                          "${classes[index].dayOfWeek} ${classes[index].startTime} - ${classes[index].endTime}",
                          style: TextStyle(
                              fontFamily: "Bellota-Regular", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.095 * MediaQuery.of(context).size.height,
                    width: 0.095 * MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text(
                                    "Potwierdź rezygnację z zajęć",
                                    style: TextStyle(
                                        fontFamily: "Bellota-Regular",
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: Text(
                                        "${classes[index].className} -  ${classes[index].Trainer}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Bellota-Regular",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                          "${classes[index].dayOfWeek} ${classes[index].startTime} - ${classes[index].endTime}"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          child: Text("Anuluj"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            "Potwierdzam",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          onPressed: () {
                                            ClassesApi().deleteClasses(classes[index].id);
                                            Navigator.of(context)
                                                .pop(); // Zamknij okno dialogowe
                                          },
                                        ),
                                      ],
                                    ),
                                  ]);
                            });
                      },
                      icon: Icon(
                        Icons.delete, // ikona zapisu
                        // dostosuj rozmiar ikony według preferencji
                      ),
                    ),
                  ),
                ],
              ),
            );
          });

  }
}
