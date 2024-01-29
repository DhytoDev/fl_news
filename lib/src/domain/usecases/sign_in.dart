
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_news/src/core/usecase.dart';
import 'package:fl_news/src/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

import '../model/user.dart';

@injectable
final class SignIn extends UseCase<User, UserLoginParams> {
  final IUserRepository _userRepository;

  SignIn(this._userRepository);

  @override
  Future<Either<Exception, User>> execute(UserLoginParams params) {
    return _userRepository.performLogin(params.userName, params.password);
  }

}

class UserLoginParams extends Equatable {

  final String userName;
  final String password;

  const UserLoginParams(this.userName, this.password);

  @override
  List<Object?> get props => [userName, password];
}