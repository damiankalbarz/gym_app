import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  bool? _acceptTerms = false;

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
            fontWeight: FontWeight.bold)),
          SizedBox(height: 26.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'IMIĘ'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'NAZWISKO'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'E-MAIL'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'TELEFON'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'HASŁO'),
            obscureText: true,
          ),
          Row(
            children: [
              Checkbox(
                value: _acceptTerms,
                activeColor: Colors.lightGreenAccent,
                tristate: true,
                onChanged: (newValue) {
                  setState(() {
                    _acceptTerms = newValue!;
                  });
                },
              ),
              Text('Akceptuję regulamin'),
            ],
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              // Tutaj można dodać logikę rejestracji
            },
            child: Text('Zarejestruj się'),
          ),
          SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Masz już konto? Zaloguj się'),
          ),
        ],
      ),
    ),
  );
}

  void setState(Null Function() param0) {}
}