import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:refresco/core/services/auth/parse_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'parse_testing_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(<String, String>{});

  MockParseApi mockApi;
  ParseAuthService authService;

  setUp(() async {
    await setupParseInstance();

    mockApi = MockParseApi();
    authService = ParseAuthService(api: mockApi);
  });

  group('ParseAuthService login', () {
    test('login with valid user', () async {
      var userEmail = 'valid@email.com';
      var userPassword = 'validPassword';
      var user = ParseUser(userEmail, userPassword, userEmail);

      var mockResponse = ParseResponse()
        ..success = true
        ..statusCode = 200
        ..count = 1
        ..error = null
        ..results = [user]
        ..result = [user];

      when(mockApi.login(any)).thenAnswer(
        (_) async => Future.value(mockResponse),
      );

      var response = await authService.loginWithEmail(
        email: userEmail,
        password: userPassword,
      );

      verify(mockApi.login(any)).called(1);
      expect(response.results, isNull);
      expect(response.message, null);
      expect(response.success, true);
    });
  });
}
