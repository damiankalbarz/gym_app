import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:firstproject/Bloc/register_bloc.dart';

void main() {
  group('RegisterBloc', () {
    late RegisterBloc registerBloc;

    setUp(() {
      registerBloc = RegisterBloc();
    });

    tearDown(() {
      // Sprzątanie zasobów
    });

    test('registerUser zwraca true dla udanej rejestracji', () async {
      // Ustal
      final expectedResponse = http.Response('{"status": "success"}', 200);

      // Zmokuj metodę http.post, aby zwracała udaną odpowiedź
      registerBloc.httpClient = MockClient((request) async => expectedResponse);

      // Akcja
      final result = await registerBloc.registerUser(
        userName: 'testUser',
        password: 'testPassword',
        confirmPassword: 'testPassword',
        fullName: 'John Doe',
        email: 'john.doe@example.com',
        phoneNumber: '123456789',
      );

      // Aserty
      expect(result, true);
    });

    test('registerUser zwraca false dla nieudanej rejestracji', () async {
      // Ustal
      final expectedResponse = http.Response('{"status": "error"}', 400);

      // Zmokuj metodę http.post, aby zwracała nieudaną odpowiedź
      registerBloc.httpClient = MockClient((request) async => expectedResponse);

      // Akcja
      final result = await registerBloc.registerUser(
        userName: 'testUser',
        password: 'testPassword',
        confirmPassword: 'testPassword',
        fullName: 'John Doe',
        email: 'john.doe@example.com',
        phoneNumber: '123456789',
      );

      // Aserty
      expect(result, false);
    });

    // Dodaj więcej testów w miarę potrzeb

  });
}

// Klasa mockująca klienta HTTP do symulacji odpowiedzi
class MockClient extends http.Client {
  final Function(MockClientRequest) _onRequest;

  MockClient(this._onRequest);

  @override
  Future<http.Response> send(http.BaseRequest request) {
    return Future.value(_onRequest(MockClientRequest(request)));
  }
}

class MockClientRequest extends http.Request {
  MockClientRequest(http.Request request) : super(request.method, request.url);

  @override
  http.ByteStream finalize() {
    return http.ByteStream.fromBytes(utf8.encode(''));
  }

  @override
  http.Response send(_) {
    return http.Response('', 200);
  }
}
