import 'package:firstproject/Bloc/register_bloc.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('RegisterBloc Tests', () {
    test('Successful registration should return true', () async {
      var registerBloc = RegisterBloc();
      var result = await registerBloc.registerUser(
        userName: 'testUser21',
        password: 'TestPassword4!',
        confirmPassword: 'TestPassword4!',
        fullName: 'John Drre',
        email: 'john@example.com',
        phoneNumber: '123456789',
      );

      expect(result, true);
    });


    test('Successful registration should return true', () async {
      var registerBloc = RegisterBloc();
      var result = await registerBloc.registerUser(
        userName: 'testUser1',
        password: 'TestPassword1!',
        confirmPassword: 'TestPassword1!',
        fullName: 'John Dao',
        email: 'john@example.com',
        phoneNumber: '123456789',
      );

      expect(result, true);
    });

    test('Failed registration should return false', () async {
      var registerBloc = RegisterBloc();
      var result = await registerBloc.registerUser(
        userName: 'testUser',
        password: 'testPassword',
        confirmPassword: 'wrongConfirmPassword', // Symulacja błędu potwierdzenia hasła
        fullName: 'John Doe',
        email: 'john.doe@example.com',
        phoneNumber: '123456789',
      );

      expect(result, false);
    });

    test('isValidEmail should return true for a valid email', () {
      var registerBloc = RegisterBloc();
      var result = registerBloc.isValidEmail('john.doe@example.com');

      expect(result, true);
    });

    test('isValidEmail should return false for an invalid email', () {
      var registerBloc = RegisterBloc();
      var result = registerBloc.isValidEmail('invalidEmail');

      expect(result, false);
    });

    test('isValidPhone should return true for a valid phone number', () {
      var registerBloc = RegisterBloc();
      var result = registerBloc.isValidPhone('123456789');

      expect(result, true);
    });

    test('isValidPhone should return false for an invalid phone number', () {
      var registerBloc = RegisterBloc();
      var result = registerBloc.isValidPhone('invalidPhone');

      expect(result, false);
    });
  });
}
