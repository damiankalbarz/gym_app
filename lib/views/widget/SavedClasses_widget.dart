import 'package:firstproject/services/classes_api.dart';
import 'package:firstproject/views/classes_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/ListClassModel.dart';

class SavedClassesWidget extends StatefulWidget {
  _SavedClassesWidgetState createState() => _SavedClassesWidgetState();
}

class _SavedClassesWidgetState extends State<SavedClassesWidget> {
  late Future<List<ListClassModel>> classes;

  @override
  void initState() {
    super.initState();
    classes = ClassesApi().getClasses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListClassModel>>(
        future: classes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<ListClassModel> classesList = snapshot.data!.toList();
            return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: snapshot.data!.length,
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
                                "${classesList[index].className}",
                                style: TextStyle(
                                    fontFamily: "Bellota-Regular",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                              Text(
                                "${classesList[index].dayOfWeek} ${classesList[index].startTime} - ${classesList[index].endTime}",
                                style: TextStyle(
                                    fontFamily: "Bellota-Regular",
                                    fontSize: 14),
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
                                              "${classesList[index].className}",
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
                                                "${classesList[index].dayOfWeek} ${classesList[index].startTime} - ${classesList[index].endTime}"),
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
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                                onPressed: () {
                                                  ClassesApi().deleteClasses(
                                                      classesList[index].id);
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        });
  }
}
