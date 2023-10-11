import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget{
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isChecked = false;

@override
Widget build(BuildContext context) {
  return Scaffold(

    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 26.0),
          const Text('REJESTRACJA', style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
              fontFamily: "Bellota-Regular")),
          SizedBox(height: 26.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'Imię', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nazwisko', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'E-mail', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.email(context),
            ]),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'Telefon', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'Hasło', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            obscureText: true,
          ),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                activeColor: Colors.lightGreenAccent,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text('Akceptuję regulamin', style: TextStyle(fontFamily: "Bellota-Regular" ),),
            ],
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              // Tutaj można dodać logikę rejestracji
            },
            child: Text('Zarejestruj się', style: TextStyle(fontFamily: "Bellota-Regular" )),
          ),
          SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Masz już konto? Zaloguj się', style: TextStyle(fontFamily: "Bellota-Regular" )),
          ),
        ],
      ),
    ),
  );
}


}