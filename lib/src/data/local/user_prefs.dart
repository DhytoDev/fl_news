import 'package:fl_news/src/data/local/preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract interface class IUserPreferences {
  Future<String?> getUser();

  Future<void> setUser(String token);

  Future<bool> clearUser();
}

@LazySingleton(as: IUserPreferences)
class UserPreferencesImpl implements IUserPreferences {
  @visibleForTesting
  final String userPrefsKey = 'user_prefs';

  @override
  Future<bool> clearUser() =>
      PreferencesHelper.removeKeyPrefs(key: userPrefsKey);

  @override
  Future<String?> getUser() => PreferencesHelper.getString(key: userPrefsKey);

  @override
  Future<void> setUser(String userName) =>
      PreferencesHelper.setString(key: userPrefsKey, value: userName);
}
