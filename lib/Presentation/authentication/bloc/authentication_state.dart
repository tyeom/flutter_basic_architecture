part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  // 초기화 되지 않음
  uninitialized,
  // 로딩중
  loading,
  // 인증 완료
  authenticated,
  // 인증 실패
  unauthenticated
}

abstract class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final MemberViewModel? userViewModel;

  const AuthenticationState(this.status, this.userViewModel);

  @override
  List<Object?> get props => [status, userViewModel];
}

/// 초기화 되지 않음
class AuthenticationUninitialized extends AuthenticationState {
  const AuthenticationUninitialized(): super(AuthenticationStatus.uninitialized, null);

  @override
  String toString() => 'AuthenticationUninitialized';
}

/// 인증 성공
class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated(MemberViewModel userViewModel): super(AuthenticationStatus.authenticated, userViewModel);

  @override
  String toString() => 'AuthenticationAuthenticated';
}

/// 인증 실패
class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated(): super(AuthenticationStatus.unauthenticated, null);

  @override
  String toString() => 'AuthenticationUnauthenticated';
}

/// 인증 처리중 [로딩]
class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading(): super(AuthenticationStatus.loading, null);

  @override
  String toString() => 'AuthenticationLoading';
}
