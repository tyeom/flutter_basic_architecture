part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IDChanged extends LoginEvent {
  final String id;
  IDChanged(this.id);

  @override
  List<Object> get props => [id];
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class Submitted extends LoginEvent {
  Submitted();
}
