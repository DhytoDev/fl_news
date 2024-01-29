import 'package:dartz/dartz.dart';
import 'package:fl_news/src/core/exceptions.dart';
import 'package:fl_news/src/data/local/user_prefs.dart';
import 'package:fl_news/src/domain/model/user.dart';
import 'package:fl_news/src/domain/repositories/user_repository.dart';

final class InMemoryUserRepository implements IUserRepository {
  InMemoryUserRepository(this.usersForPassword, this._userPreferences);

  final Map<String, List<User>> usersForPassword;
  final IUserPreferences _userPreferences;

  @override
  Future<Either<NetworkException, User>> performLogin(
      String userName, String password) async {
    try {
      final user =
          usersForPassword[password]?.firstWhere((e) => e.userName == userName);

      if (user == null) {
        return left(
            const NetworkException(status: 404, message: 'User not found'));
      }

      await _userPreferences.setUser(userName);

      return right(user);
    } on StateError catch (e) {
      return left(NetworkException(status: 404, message: e.message));
    }
  }

  @override
  Future<Option<User>> getUser() async {
    final userName = await _userPreferences.getUser();

    if (userName == null) return none();

    final user = User.users.firstWhere(
      (e) => userName == e.userName,
    );

    return optionOf(user);
  }

  @override
  Future<bool> signOut() async {
    return await _userPreferences.clearUser();
  }
}
