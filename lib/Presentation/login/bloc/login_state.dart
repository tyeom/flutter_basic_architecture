part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final IDInput id;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const LoginState(
      {required this.id,
      required this.password,
      required this.status,
      this.errorMessage,
      this.isValid = false});

  LoginState copyWith({
    IDInput? id,
    PasswordInput? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    final String? errorMessage
  }) {
    return LoginState(
      id: id ?? this.id,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [status, id, password];
}
