import 'package:firstproject/profil_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class RegisterPage extends StatefulWidget{
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool isChecked = false;

  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$';
    final regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    final phonePattern = r'^\d{9,12}$';
    final regex = RegExp(phonePattern);
    return regex.hasMatch(phone);
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
      key: _formKey,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pole "Imię" jest wymagane.';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nazwisko', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pole "Nazwisko" jest wymagane.';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'E-mail', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pole "E-mail" jest wymagane.';
              }
              if (!_isValidEmail(value)) {
                return 'Nieprawidłowy adres email.';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Telefon', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pole "Telefon" jest wymagane.';
              }
              if (!_isValidPhone(value)) {
                return 'Nieprawidłowy numer telefonu.';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'Hasło', labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Pole "Hasło" jest wymagane.';
            }
            if (value.length < 8) {
              return 'Hasło musi mieć co najmniej 8 znaków.';
            }
            return null;
            },
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
          SizedBox(height: 13.0),
          Flexible(
            child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilPage()));
              }
            },
            child: Text('Zarejestruj się', style: TextStyle(fontFamily: "Bellota-Regular", fontWeight: FontWeight.w500, fontSize: 30 )),
          ),
          ),
          SizedBox(height: 11.0),
          Flexible(
            child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Masz już konto? Zaloguj się', style: TextStyle(fontFamily: "Bellota-Regular", fontWeight: FontWeight.bold ),
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