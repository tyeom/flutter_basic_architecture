part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  
  AuthenticationStatusChanged(this.status);
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}