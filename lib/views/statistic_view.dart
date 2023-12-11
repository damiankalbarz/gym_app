import 'dart:typed_data';

import 'package:firstproject/Model/GymEnteryRank.dart';
import 'package:firstproject/services/gymEntry_api.dart';
import 'package:firstproject/views/widget/UserStatistic_widget.dart';
import 'package:flutter/material.dart';
import '../navigation/navigation.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  int _currentIndex = 3;
  late Future<List<GymEntryRank>> rank;

  @override
  void initState() {
    super.initState();
    rank = GymEntryApi().getEntryRank().then((list) {
      list.sort((a, b) => b.numberOfEntries.compareTo(a.numberOfEntries));
      return list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 0.05 * MediaQuery.of(context).size.height,
              ),
              const Text('Statystyki',
                  style:
                      TextStyle(fontSize: 32, fontFamily: "Bellota-Regular")),
              SizedBox(
                height:15,
              ),
              UserStatisticWidget(),
              Center(
                child: Text(
                  'Ranking',
                  style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),
                ),
              ),
              SizedBox(height: 15),
              FutureBuilder<List<GymEntryRank>>(
                  future: rank,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<GymEntryRank> rankList = snapshot.data!;
                      return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 0.5),
                        padding: EdgeInsets.zero,
                        itemCount: rankList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white12
                                      : Colors.blue,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const <int, TableColumnWidth>{
                                  0: IntrinsicColumnWidth(),
                                  1: FixedColumnWidth(48),
                                  2: FlexColumnWidth(),
                                  3: FlexColumnWidth(),
                                  4: FlexColumnWidth(),
                                },
                                children: <TableRow>[
                                  TableRow(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Image.memory(
                                          rankList[index].profilePicture!,
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Bellota-Regular",
                                        ),
                                      ),
                                      ),
                                      Container(
                                        //width: 300,
                                        child: Text(
                                          rankList[index].userName!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Bellota-Regular",
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          rankList[index]
                                              .numberOfEntries
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Bellota-Regular",
                                          ),
                                        ),
                                      ),
                                      Text(
                                        rankList[index]
                                            .timeSpend!
                                            .substring(0, 5),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Bellota-Regular",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Dodaj inne pola z obiektu MyObject, jeśli są
                          );
                        },
                      );
                    }
                  }),
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
