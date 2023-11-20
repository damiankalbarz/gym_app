import 'package:firstproject/Model/GymEnteryRank.dart';
import 'package:firstproject/services/gymEntry_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserStatisticWidget extends StatefulWidget {
  _UserStatisticWidgetState createState() => _UserStatisticWidgetState();
}

class _UserStatisticWidgetState extends State<UserStatisticWidget> {
  late Future<GymEntryRank> stats;

  @override
  void initState() {
    super.initState();
    stats = GymEntryApi().getWeekStats();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text(
              'Podsumowanie twojch treningow w tym tygogniu',
              style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10,),
          FutureBuilder<GymEntryRank>(
            future: stats,
            builder: (context, snapshot) {
              String time = snapshot.data!.timeSpend.substring(0,5);
              List<String> timeSplit = time.split(':');
              int hours = int.parse(timeSplit[0]);
              int minutes = int.parse(timeSplit[1]);
              int avgMinutes = (hours*60+minutes) ~/ snapshot.data!.numberOfEntries;
              print(avgMinutes);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("W tym tygodni odbyłeś ${snapshot.data!.numberOfEntries} treningów",style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 18),),
                      Text("Spedziłeś na silowni łacznie ${time} godzin",style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 18)),
                      Text("Średnio na jeden trenig potrzebujesz $avgMinutes minut",style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 18),),
                    ],
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ],
      ),
    );
  }
}
