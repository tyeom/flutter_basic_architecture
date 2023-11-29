import 'package:basic_architecture/App/app_preferences.dart';
import 'package:basic_architecture/Domain/usecase/login_usecase.dart';
import 'package:basic_architecture/Presentation/login/forms/id_input.dart';
import 'package:basic_architecture/Presentation/login/forms/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppPreferences _appPreferences;
  final LoginUseCase _loginUseCase;

  LoginBloc(this._appPreferences, this._loginUseCase)
      : super(const LoginState(
            id: IDInput.pure(),
            password: PasswordInput.pure(),
            status: FormzSubmissionStatus.initial)) {
    on<IDChanged>(_onIDChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<Submitted>(_onSubmitted);
  }

  void _onIDChanged(
    IDChanged event,
    Emitter<LoginState> emit,
  ) {
    final id = IDInput.dirty(event.id);
    emit(
      state.copyWith(
        id: id,
        isValid: Formz.validate([state.password, id]),
      ),
    );
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = PasswordInput.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.id]),
      ),
    );
  }

  Future<void> _onSubmitted(
    Submitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        (await _loginUseCase.execute(
                LoginUseCaseInput(state.id.value, state.password.value)))
            .fold((left) {
          emit(state.copyWith(
              status: FormzSubmissionStatus.failure, errorMessage: left));
        }, (right) {
          _appPreferences.login();
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        });
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
