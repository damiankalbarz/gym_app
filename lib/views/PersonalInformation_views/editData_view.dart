import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firstproject/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:image_cropper/image_cropper.dart';

import 'package:firstproject/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'changePassword_view.dart';
import 'changePersonalInformation_view.dart';
import 'deleteAccount_view.dart';


class EditDataPage extends StatefulWidget {
  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  File? _image;
  Uint8List? _imageBytes;


  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _imageBytes = _image!.readAsBytesSync();
        UserApi().sendImageToServer(_imageBytes!);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edycja danych'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  height: 0.2 * MediaQuery.of(context).size.height,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PersonalInformation();
                      },
                      );
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Theme.of(context).brightness == Brightness.dark
                            ? Colors.white12
                            : Colors.blue;
                      },),),
                    child: Text("Podgląd/Edycja danych osobistych", style: TextStyle(fontFamily: "Bellota-regular"),),
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 0.2 * MediaQuery.of(context).size.height,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return changePassword(context);
                        });
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.blue;
                    },),),
                  child: Text("Zmień hasło",style: TextStyle(fontFamily: "Bellota-regular"),),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 0.2 * MediaQuery.of(context).size.height,
                child: ElevatedButton(
                  onPressed: getImage,
                  child: Text('Zmień zdjęcie profilowe'),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.blue;
                    },),),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 0.2 * MediaQuery.of(context).size.height,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return deleteAccount(context);
                      },
                    );
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.red;
                    },),),
                  child: Text(
                    'Usuń konto',
                    style: TextStyle(fontFamily: "Bellota-regular"),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
