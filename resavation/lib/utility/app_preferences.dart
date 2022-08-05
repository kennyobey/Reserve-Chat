import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences? _preference;

  static Future init() async =>
      _preference = await SharedPreferences.getInstance();

  // on boarding value is true if logged in
  static const _onBoardingKey = 'onBoardingStatus';

  static const _refreshTokenKey = 'refreshToken';
  static const _accessRolesKey = 'accessRolesKey';
  static const _tokenTypeKey = 'tokenTypeKey';

  static Future setOnBoardingStatus({required bool status}) async {
    await _preference?.setBool(_onBoardingKey, status);
  }

  static Future setRefeshTokenAndAccessRole(
      {required String token,
      required List<String> accessRoles,
      required String tokenType}) async {
    await _preference?.setString(_refreshTokenKey, token);
    await _preference?.setString(_tokenTypeKey, tokenType);
    await _preference?.setStringList(_accessRolesKey, accessRoles);
  }

  static bool get hasUserSeenOnBoarding =>
      _preference?.getBool(_onBoardingKey) ?? false;

  static String get getRefeshToken =>
      _preference?.getString(_refreshTokenKey) ?? '';
  static String get getTokenType => _preference?.getString(_tokenTypeKey) ?? '';
  static List<String> get getAccessRoles =>
      _preference?.getStringList(_accessRolesKey) ?? [];
}
