import 'dart:convert';

import 'package:http/http.dart';

class Registration {
  final Client _client;

  Registration(Client client) : this._client = client;

  factory Registration.app() {
    return Registration(Client());
  }

  Future<Map<String, dynamic>> accounts(String name, int age) async {
    var uri = Uri.parse('http://localhost:8181/api/v1/accounts');
    var response = await _client.post(uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "age": age,
        }));

    var body = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw RegistrationException(body['error'], -1);
    }

    return body;
  }
}

class RegistrationException implements Exception {
  final String message;
  final int code;

  RegistrationException(this.message, this.code);
}
