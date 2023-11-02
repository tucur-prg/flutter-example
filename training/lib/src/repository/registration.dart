import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';

import '../value/access_token.dart';

class Registration {
  final Client _client;

  Registration(Client client) : _client = client;

  factory Registration.app() {
    return Registration(Client());
  }

  Future<String> _safeApiCall(Function() callback) async {
    try {
      final response = await callback() as Response;
      return _parseResponse(response.statusCode, response.body);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }

  String _parseResponse(int httpStatus, String responseBody) {
    switch (httpStatus) {
      case 200:
      case 201:
      case 204:
        return responseBody;
      case 400:
      case 401:
      case 402:
      case 403:
      case 404:
        throw RegistrationException('Http status 400-', httpStatus);
      case 500:
      case 501:
      case 502:
      case 503:
        throw RegistrationException('Http status 500-', httpStatus);
      default:
        throw Exception('Http status $httpStatus unknown error.');
    }
  }

  Future<Map<String, dynamic>> accounts(AccessToken token, String name, int age) async {
    var uri = Uri.parse('http://localhost:8181/api/v1/accounts');
    var body = await _safeApiCall(() async => await _client.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer ${token.value}",
        },
        body: jsonEncode({
          "name": name,
          "age": age,
        })));

    return jsonDecode(body);
  }
}

class RegistrationException implements Exception {
  final String message;
  final int code;

  RegistrationException(this.message, this.code);
}
