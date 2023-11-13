import 'dart:typed_data';

import 'package:firstproject/Model/GymEnteryRank.dart';
import 'package:firstproject/services/gymEntry_api.dart';
import 'package:flutter/material.dart';
import '../navigation.dart';

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
    rank = GymEntryApi().getEntryRank();
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
              const Text('Statystki',
                  style:
                      TextStyle(fontSize: 32, fontFamily: "Bellota-Regular")),
              SizedBox(
                height: 0.05 * MediaQuery.of(context).size.height,
              ),
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
                            SizedBox(height: 2),
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
                              child: Row(

                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, // Kolor ramki
                                        width: 2.0, // Grubość ramki
                                      ),
                                    ),
                                    child: Image.memory(
                                      rankList[index].profilePicture,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                  Text(rankList[index].userName, style: TextStyle(fontSize: 15, fontFamily: "Bellota-Regular",),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(rankList[index]
                                      .numberOfEntries
                                      .toString(), style: TextStyle(fontSize: 15, fontFamily: "Bellota-Regular",),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(rankList[index].timeSpend, style: TextStyle(fontSize: 15, fontFamily: "Bellota-Regular",),),
                           ],),
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
