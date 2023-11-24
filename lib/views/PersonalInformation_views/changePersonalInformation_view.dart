import 'package:firstproject/services/user_api.dart';
import 'package:flutter/material.dart';
import '../../Model/User.dart';

class PersonalInformation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final UserApi api = UserApi();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    api.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Edycja danych personalnych",
        style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 20),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        StreamBuilder<User>(
          stream: api.userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return Column(
                children: [
                  Text(
                    "Nazwa Użytkownika",
                    style:
                        TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: user.userName,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Imie i Nazwisko",
                    style:
                        TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextFormField(
                    controller: _fullNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: user.fullName,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Email",
                    style:
                        TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: user.email,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Telefon Komórkowy",
                    style:
                        TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: user.phoneNumber,
                      labelStyle: TextStyle(fontFamily: "Bellota-Regular"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: Text("Anuluj"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.all(8.0),
                          child: TextButton(
                            child: Text(
                              "Zatwierdź zmiany",
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              UserApi().changePersonalInformation(
                                  _phoneNumberController.text,
                                  _fullNameController.text,
                                  _emailController.text);
                              Navigator.of(context)
                                  .pop(); // Zamknij okno dialogowe
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
