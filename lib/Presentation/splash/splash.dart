import 'dart:async';

import 'package:basic_architecture/Presentation/authentication/bloc/authentication_bloc.dart';
import 'package:basic_architecture/Presentation/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    context
        .read<AuthenticationBloc>()
        .add(AuthenticationStatusChanged(AuthenticationStatus.loading));
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
            } else if (state.status == AuthenticationStatus.loading) {
              //
            } else {
              Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
            }
          },
          // 보통 앱의 로고를 표시하고, 인증 여부를 체크 한다.
          // 인증 토큰을 로컬 캐시에 보관하고, 토큰 유효성 검사 성공인 경우 Main home page로 이동
          // 인증 토큰이 존재 하지 않거나, 토큰 유효성 검사 실패인 경우 Login page로 이동
          child: const Center(
            child: CircularProgressIndicator(),
          ));
}
