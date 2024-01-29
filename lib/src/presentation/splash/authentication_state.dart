import 'package:equatable/equatable.dart';

import '../../domain/model/user.dart';

class AuthenticationState extends Equatable {
  final AuthState? authState;
  final User? user;

  const AuthenticationState(this.authState, [this.user]);

  factory AuthenticationState.initial() => const AuthenticationState(null);

  factory AuthenticationState.authenticated(User user) =>
       AuthenticationState(AuthState.authenticated, user);

  factory AuthenticationState.unauthenticated() =>
      const AuthenticationState(AuthState.unauthenticated, null);

  @override
  List<Object?> get props => [authState];
}

enum AuthState { authenticated, unauthenticated }
