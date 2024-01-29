import 'package:equatable/equatable.dart';
import 'package:fl_news/src/presentation/sign_in/user_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/sign_in.dart';
import 'password.dart';

part 'login_event.dart';

part 'login_state.dart';

@injectable
final class SignInBloc extends Bloc<LoginEvent, LoginState> {
  final SignIn _signIn;

  SignInBloc(this._signIn) : super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.password, username]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _signIn
          .execute(UserLoginParams(state.username.value, state.password.value));

      return result.fold(
        (l) {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        },
        (r) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        },
      );
    }
  }
}
