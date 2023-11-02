import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';

import 'package:training/src/repository/registration.dart';
import 'package:training/src/value/access_token.dart';

import 'registration_test.mocks.dart';

@GenerateMocks([Client])
main() {
  late MockClient client;

  setUp(() {
    client = MockClient();
  });

  test('constructor', () {
    var obj = Registration(client);
  });

  group('登録', () {
    test('成功', () async {
      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response('{"id":1}', 201));

      var obj = Registration(client);

      expect(await obj.accounts(AccessToken('aaa'), 'bob', 20), {"id": 1});
    });

    test('重複', () async {
      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async =>
              Response('Not Found', 404));

      var obj = Registration(client);

      expect(
          () async => await obj.accounts(AccessToken('aaa'), 'bob', 20),
          throwsA(isA<RegistrationException>()
              .having((e) => e.message, 'エラーメッセージ', 'Http status 400-')
              .having((e) => e.code, 'エラーコード', 404)));
    });
  });
}
