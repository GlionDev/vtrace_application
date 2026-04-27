import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_local_datasource.dart';
import 'auth_pref_keys.dart';

/// [AuthLocalDataSource] 의 SharedPreferences + SecureStorage 기반 구현체입니다.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  /// [AuthLocalDataSourceImpl] 객체를 생성합니다.
  ///
  /// [prefs] 키-값 저장에 사용할 SharedPreferences 인스턴스
  /// [secureStorage] 보안 스토리지 인스턴스
  const AuthLocalDataSourceImpl({
    required SharedPreferences prefs,
    required FlutterSecureStorage secureStorage,
  }) : _prefs = prefs,
       _secureStorage = secureStorage;

  @override
  Future<void> saveRememberMe({
    required bool rememberMe,
    required String email,
  }) async {
    await _prefs.setBool(AuthPrefKeys.rememberMe, rememberMe);
    if (rememberMe) {
      await _prefs.setString(AuthPrefKeys.lastLoginEmail, email);
    } else {
      await _prefs.remove(AuthPrefKeys.lastLoginEmail);
    }
  }

  @override
  Future<bool> getRememberMe() async {
    return _prefs.getBool(AuthPrefKeys.rememberMe) ?? false;
  }

  @override
  Future<String?> getLastLoginEmail() async {
    return _prefs.getString(AuthPrefKeys.lastLoginEmail);
  }

  @override
  Future<void> saveAccessToken(String token) {
    return _secureStorage.write(
      key: AuthSecureKeys.accessToken,
      value: token,
    );
  }

  @override
  Future<String?> getAccessToken() {
    return _secureStorage.read(key: AuthSecureKeys.accessToken);
  }

  @override
  Future<void> clear() async {
    await _prefs.remove(AuthPrefKeys.rememberMe);
    await _prefs.remove(AuthPrefKeys.lastLoginEmail);
    await _secureStorage.delete(key: AuthSecureKeys.accessToken);
  }
}
