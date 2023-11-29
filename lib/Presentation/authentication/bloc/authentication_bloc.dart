import 'package:basic_architecture/App/app_preferences.dart';
import 'package:basic_architecture/Domain/usecase/login_usecase.dart';
import 'package:basic_architecture/Domain/usecase/logout_usecase.dart';
import 'package:basic_architecture/Domain/usecase/member_info_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'member_viewmodel.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AppPreferences _appPreferences;
  final LogoutUseCase _logoutUseCase;
  final MemberInfoUseCase _memberInfoUseCase;

  AuthenticationBloc(
      this._appPreferences, this._logoutUseCase, this._memberInfoUseCase)
      : super(const AuthenticationUninitialized()) {
    on<AuthenticationStatusChanged>(
        (e, __) => onAuthenticationStatusChanged(e.status));
    on<AuthenticationLogoutRequested>(
        (_, __) => onAuthenticationLogoutRequested());
  }

  Future<void> onAuthenticationStatusChanged(
      AuthenticationStatus status) async {
    // test!
    //////////////await _appPreferences.logout();
    switch (status) {
      case AuthenticationStatus.loading:
        // 로그인 되어 있는 상태라면,
        // secure storage에 보관되어 있는 AccessToken으로 사용자 정보를 가져온다.
        // 사용자 정보 요청 성공인 경우 Main home page로 이동
        // 로그인 되어 있지 않은 상태거나, AccessToken 토큰이 유효하지 않아 사용자 정보 요청 실패인 경우 Login page로 이동
        var isUserLoggedIn = _appPreferences.userToken;
        if (isUserLoggedIn == null || isUserLoggedIn == false) {
          emit(const AuthenticationUninitialized());
        } else {
          onAuthenticationStatusChanged(AuthenticationStatus.authenticated);
        }
        break;

      case AuthenticationStatus.uninitialized:
        emit(const AuthenticationUninitialized());
        break;

      case AuthenticationStatus.authenticated:
        final memberResult = await _memberInfoUseCase.execute(null);
        memberResult.fold(
            (left) => emit(const AuthenticationUnauthenticated()),
            (right) => {
                  if (right != null)
                    {
                      emit(AuthenticationAuthenticated(MemberViewModel(
                          no: right.no,
                          id: right.id,
                          name: right.name,
                          email: right.email,
                          tel: right.tel,
                          subscriptionKey: right.subscriptionKey)))
                    }
                  else
                    {emit(const AuthenticationUnauthenticated())}
                });

        break;

      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationUnauthenticated());
        break;

      default:
        emit(const AuthenticationUninitialized());
        break;
    }
  }

  Future<void> onAuthenticationLogoutRequested() async {
    await _appPreferences.logout();
    final result = await _logoutUseCase.execute(null);
    result.fold((l) => null, (r) => emit(const AuthenticationUninitialized()));
  }
}
