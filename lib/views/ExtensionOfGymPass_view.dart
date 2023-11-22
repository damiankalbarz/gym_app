import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/GymPassPriceModel.dart';
import '../services/gymPass_api.dart';

class ExtensionOfGymPassPage extends StatefulWidget {
  _ExtensionOfGymPassPageState createState() => _ExtensionOfGymPassPageState();
}

class _ExtensionOfGymPassPageState extends State<ExtensionOfGymPassPage> {
  late Future<List<GymPassPrice>> list;
  int? selectedPassIndex;
  String? length;

  int convertTime(String length){
    int lengthI;
    switch(length){
      case "Month":
        lengthI = 31;
        break;
      case "Quarter":
        lengthI = 92;
        break;
      case "HalfYear":
        lengthI = 183;
        break;
      case "Year":
        lengthI = 365;
        break;
      default:
        lengthI = 0;
    }
    return lengthI;
  }

  @override
  void initState() {
    super.initState();
    list = GymPassApi().getPassPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Przedłużenie karnetu'),
      ),
      body: Container(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Text("Wybierz długość karnetu", style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),),
            SizedBox(height: 10),
            Container(
              height: 300,
            child: FutureBuilder<List<GymPassPrice>>(
                future: list,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    print(snapshot.data![0].length);
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<int>(
                          title: Text("${snapshot.data![index].length}", style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 18),),
                          subtitle:
                              Text('Cena: ${snapshot.data![index].price}', style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),),
                          value: index,
                          groupValue: selectedPassIndex,
                          onChanged: (int? value) {
                            setState(() {
                              selectedPassIndex = value;
                              length= snapshot.data![index].length;
                            });
                          },
                        );
                      },
                    );
                  }
                }),
            ),
            SizedBox(height: 10,),
            Text("Wybierz metode płatności", style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                if(selectedPassIndex != null){
                  GymPassApi().extendPass(convertTime(length!));
                }
                },
              child:
              Container(
                width: 300,
                height: 50,
                child: Image.asset("assets/przelewy24/Przelewy24_logo.png",
                //fit: BoxFit.contain,
                ),
              ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Theme.of(context).brightness == Brightness.dark
                      ? Colors.white12
                      : Colors.blue;
                },
              ),),
            ),



          ],
        ),
      ),
      ),
    );
  }
}
