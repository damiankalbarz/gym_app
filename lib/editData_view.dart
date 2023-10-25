import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';

import 'package:firstproject/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'PersonalInformation_views/changePersonalInformation_view.dart';

class EditDataPage extends StatefulWidget {
  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  File? _image;
  Uint8List? _imageBytes;
  final _passwordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  AlertDialog changePassword(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Zmiana hasła",
        style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 20),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Text(""),
        TextFormField(
          controller: _oldPasswordController,
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              labelText: 'Obecne hasło',
              labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
        ),
        SizedBox(
          height: 7,
        ),
        TextFormField(
          controller: _newPasswordController,
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              labelText: 'Nowe hasło',
              labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
        ),
        SizedBox(
          height: 7,
        ),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              labelText: 'Potwierdź hasło',
              labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text("Anuluj"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Zmień hasło",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                changePasswordApi();
                Navigator.of(context).pop(); // Zamknij okno dialogowe
              },
            ),
          ],
        ),
      ],
    );
  }

  void changePasswordApi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.put(
        Uri.parse('https://localhost:7286/api/User/change-password'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "currentPassword": _oldPasswordController.text,
          "newPassword": _newPasswordController.text,
          "confirmPassword": _confirmPasswordController.text
        }),
      );

      if (response.statusCode == 200) {
        print('Password change successfully');
        // Tutaj możesz dodać nawigację lub inne działania po usunięciu konta
      } else {
        print('Passwor change failed with status: ${response.statusCode}');
        // Tutaj możesz dodać obsługę błędów
      }
    } catch (e) {
      print('Error during account deletion: $e');
      // Tutaj możesz dodać bardziej szczegółową obsługę błędów
    }
  }

  void deleteUserAccount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.delete(
        Uri.parse('https://localhost:7286/api/User/delete-account'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(_passwordController.text),
      );

      if (response.statusCode == 200) {
        print('Account deleted successfully');
        // Tutaj możesz dodać nawigację lub inne działania po usunięciu konta
      } else {
        print('Account deletion failed with status: ${response.statusCode}');
        // Tutaj możesz dodać obsługę błędów
      }
    } catch (e) {
      print('Error during account deletion: $e');
      // Tutaj możesz dodać bardziej szczegółową obsługę błędów
    }
  }

  /*

  Future<File> compressAndGetFile(File file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    img.Image? image = img.decodeImage(file.readAsBytesSync());
    img.Image smallerImage = img.copyResize(image!, width: 500); // Możesz zmienić szerokość na odpowiednią dla Twojego przypadku

    File compressedFile = new File('$path/img.jpg')
      ..writeAsBytesSync(img.encodeJpg(smallerImage, quality: 85)); // Możesz dostosować jakość w zależności od Twoich wymagań

    return compressedFile;
  }





  Future<File?> _cropImage(File imageFile) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
        aspectRatioLockEnabled: true,
        aspectRatioPickerButtonHidden: true,
        minimumAspectRatio: 1.0,
      ),
    );
    return croppedFile;
  }

  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    if (image != null) {
      File? croppedImage = await _cropImage(File(image.path));
      if (croppedImage != null) {
        File? compressedImage = await compressAndGetFile(File(image.path));
        File? croppedImage = await _cropImage(compressedImage!);
        if (croppedImage != null) {
          setState(() {
            _image = croppedImage;
            _imageBytes = _image!.readAsBytesSync();
          });
          print('${_imageBytes!.length} koniec');
        }
      }
    }
  }

*/
  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
        _imageBytes = _image!.readAsBytesSync();
      });
      print('${_imageBytes!.length} koniec');
    }
  }

  void sendImageToServer(Uint8List imageBytes) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token'); // Zmiana na typ String?
      //print(byteString.length);
      var response = await http.put(
        Uri.parse('https://localhost:7286/api/User/change-picture'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(base64Encode(_imageBytes!)),
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        // Tutaj można umieścić logikę obsługi sukcesu
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        // Tutaj można umieścić logikę obsługi błędu
      }
    } catch (e) {
      print('Error during image upload: $e');
      // Tutaj można umieścić bardziej szczegółową logikę obsługi błędów
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edycja dancych'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  height: 0.2 * MediaQuery.of(context).size.height,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return changePersonalInformation(context);
                          });
                    },
                    child: Text("Dane personalne"),
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
                  child: Text("Zmień hasło"),
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
                        return AlertDialog(
                          title: Text("Potwierdź usuniecie konta",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: "Bellota-Regular")),

                          actions: <Widget>[
                            Text(
                                "Czy na pewno chcesz usunąć swoje konto? Ta operacja jest nieodwracalna.",
                                style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 16), textAlign: TextAlign.center,),
                            SizedBox(height: 10,),
                            Text("Wprowadź hasło w celu usniecia konta",
                                style:
                                    TextStyle(fontFamily: "Bellota-Regular")),
                            SizedBox(height: 5,),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'Hasło',
                                  labelStyle:
                                      TextStyle(fontFamily: "Bellota-Regular")),
                              obscureText: true,
                            ),
                            Row(
                              children: [
                                TextButton(
                                  child: Text("Anuluj"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Expanded(child:
                                Container(
                                  alignment: Alignment.centerRight,
                                child: TextButton(
                                  child: Text(
                                    "Usuń konto",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    deleteUserAccount();
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
                      },
                    );
                  },
                  child: Text(
                    'Usuń konto',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red), // Kolor tła przycisku
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 0.6 * MediaQuery.of(context).size.width,
                      height: 0.3 * MediaQuery.of(context).size.height,
                      child: ElevatedButton(
                        onPressed: getImage,
                        child: Text('Dodaj zdjecie'),
                      ),
                    ),
                    Container(
                      width: 0.3 * MediaQuery.of(context).size.width,
                      height: 0.3 * MediaQuery.of(context).size.height,
                      child: _image == null
                          ? Text('No image selected.')
                          : Image.file(_image!),
                    ),
                  ],
                ),
              ),
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 0.2 * MediaQuery.of(context).size.height,
                child: ElevatedButton(
                  onPressed: () {
                    sendImageToServer(_imageBytes!);
                  },
                  child: Text('Wyślij zdjęcie na serwer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
