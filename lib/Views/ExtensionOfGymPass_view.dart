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
  String? selectedLength;

  int convertTime(String length) {
    int lengthI;
    switch (length) {
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

  String TranslationTerm(String termEN) {
    String termPL;
    switch (termEN) {
      case "Month":
        termPL = "Miesiąc";
        break;
      case "Quarter":
        termPL = "Kwartał";
        break;
      case "HalfYear":
        termPL = "Pół roku";
        break;
      case "Year":
        termPL = "Rok";
        break;
      default:
        termPL = "";
    }
    return termPL;
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
        title: const Text('Przedłużenie karnetu', style: TextStyle(fontFamily: "Bellota-Regular")),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                "Wybierz długość karnetu",
                style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 22),
              ),
              SizedBox(height: 10),
              Container(
                height: 305,
                child: FutureBuilder<List<GymPassPrice>>(
                    future: list,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return RadioListTile<int>(
                              title: Text(
                                "${TranslationTerm(snapshot.data![index].length)}",
                                style: TextStyle(
                                    fontFamily: "Bellota-Regular",
                                    fontSize: 18),
                              ),
                              subtitle: Text(
                                'Cena: ${snapshot.data![index].price}',
                                style: TextStyle(
                                    fontFamily: "Bellota-Regular",
                                    fontSize: 14),
                              ),
                              value: index,
                              groupValue: selectedPassIndex,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedPassIndex = value;
                                  selectedLength = snapshot.data![index].length;
                                });
                              },
                            );
                          },
                        );
                      }
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPassIndex != null) {
                      GymPassApi().extendPass(convertTime(selectedLength!));
                    }
                  },
                  child: Text(
                    "Zapłać",
                    style:
                        TextStyle(fontSize: 28, fontFamily: "Bellota-Regular"),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Theme.of(context).brightness == Brightness.dark
                            ? Colors.white12
                            : Colors.blue;
                      },
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
