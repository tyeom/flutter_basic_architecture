import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_USER_LOGIN = "USER_LOGIN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  /// 로그인 완료시, 추후 자동 로그인 사용
  bool? get userToken => _sharedPreferences.getBool(PREFS_KEY_USER_LOGIN);

  Future<void> login() =>
      _sharedPreferences.setBool(PREFS_KEY_USER_LOGIN, true);

  Future<void> logout() async {
    await _sharedPreferences.remove(PREFS_KEY_USER_LOGIN);
  }
}
