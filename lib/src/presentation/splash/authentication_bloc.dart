import 'dart:async';

import 'package:fl_news/src/domain/repositories/user_repository.dart';
import 'package:fl_news/src/presentation/splash/authentication_event.dart';
import 'package:fl_news/src/presentation/splash/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IUserRepository _userRepository;

  AuthenticationBloc(this._userRepository)
      : super(AuthenticationState.initial()) {
    on<GetAuthenticationStatusEvent>(_getAuthenticationStatus);
    on<SignOutEvent>(_onSignOut);
  }

  FutureOr<void> _getAuthenticationStatus(GetAuthenticationStatusEvent event,
      Emitter<AuthenticationState> emit) async {
    final user = await _userRepository.getUser();

    return user.fold(() {
      emit(AuthenticationState.unauthenticated());
    }, (userLoggedIn) {
      emit(AuthenticationState.authenticated(userLoggedIn));
    });
  }

  FutureOr<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    final signedOut = await _userRepository.signOut();

    if (signedOut) emit(AuthenticationState.unauthenticated());
  }
}
