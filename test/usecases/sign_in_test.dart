import 'package:dartz/dartz.dart';
import 'package:fl_news/src/core/exceptions.dart';
import 'package:fl_news/src/data/local/user_prefs.dart';
import 'package:fl_news/src/data/repositories/user_repository.dart';
import 'package:fl_news/src/domain/model/user.dart';
import 'package:fl_news/src/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final Map<String, List<User>> usersForPassword = {
    "magnusaja": [User.users[0]],
    "dhyto": [User.users[1]]
  };

  SharedPreferences.setMockInitialValues({});

  final mockUserPrefs = UserPreferencesImpl();

  final userRepository =
      InMemoryUserRepository(usersForPassword, mockUserPrefs);

  final sut = SignIn(userRepository);

  test('login successfully', () async {
    final result =
        await sut.execute(const UserLoginParams('magnus', 'magnusaja'));

    expect(result, right(User.users.first));
  });

  test('user not found', () async {
    final result = await sut.execute(const UserLoginParams('magnus', 'magnus'));

    expect(result,
        left(const NetworkException(status: 404, message: 'User not found')));
  });
}
