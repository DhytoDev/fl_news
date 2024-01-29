import 'package:dartz/dartz.dart';
import 'package:fl_news/src/core/exceptions.dart';

import '../model/user.dart';

abstract interface class IUserRepository {
  Future<Either<NetworkException, User>> performLogin(
      String userName, String password);

  Future<Option<User>> getUser();

  Future<bool> signOut();
}
