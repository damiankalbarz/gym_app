import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/ProfilPicture.dart';
import '../../Model/User.dart';
import '../../services/user_api.dart';
import '../settings_view.dart';

class WelcomeWidget extends StatefulWidget {
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  final UserApi api = UserApi();

  @override
  void initState() {
    super.initState();
    api.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: api.userStream,
      builder: (context, snapshot) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                      left: 10,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.065,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black26
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(color: borderColor, width: 2),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.22,
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
                                          builder: (context) => SettingsView()),
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
                      child: StreamBuilder<ProfilePicture>(
                        stream: api.pictureStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor, width: 2,),
                              ),
                              child: ClipOval(
                                child: Image.memory(
                                  snapshot.data!.content,
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height: MediaQuery.of(context).size.width * 0.15,
                                  fit: BoxFit.cover,
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
                  style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 32),
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
    );
  }
}
