import 'package:basic_architecture/Presentation/authentication/bloc/authentication_bloc.dart';
import 'package:basic_architecture/Presentation/login/bloc/login_bloc.dart';
import 'package:basic_architecture/Presentation/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Widget _loginWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 300,
                    height: 150,
                    child: Image.asset('assets/images/flutter-logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: BlocBuilder<LoginBloc, LoginState>(
                  // 현재 아이디 입력 상태의 유효성 체크가 이전 아이디 입력 상태 유효성 체크와 다른 경우 일때만 빌드 한다.
                  buildWhen: (prev, cur) => prev.id.isValid != cur.id.isValid,
                  builder: (context, state) {
                    return TextField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'ID',
                          hintText: 'Enter your ID',
                          errorText: state.id.displayError),
                      onChanged: (id) =>
                          context.read<LoginBloc>().add(IDChanged(id)),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (prev, cur) =>
                      prev.password.isValid != cur.password.isValid,
                  builder: (context, state) {
                    return TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password',
                          errorText: state.password.displayError),
                      onChanged: (id) =>
                          context.read<LoginBloc>().add(PasswordChanged(id)),
                    );
                  }),
            ),
            TextButton(
              onPressed: () {
                // TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                AppLocalizations.of(context)!.forgotPassword,
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Builder(builder: (context) {
                return BlocConsumer<LoginBloc, LoginState>(
                  buildWhen: (prev, cur) => prev.status != cur.status,
                  builder: (context, state) {
                    return TextButton(
                      onPressed: state.status ==
                              FormzSubmissionStatus.inProgress
                          ? null
                          : () => context.read<LoginBloc>().add(Submitted()),
                      child: (state.status == FormzSubmissionStatus.inProgress)
                          ? const CircularProgressIndicator()
                          : Text(
                              AppLocalizations.of(context)!.login,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    );
                  },
                  listenWhen: (prev, cur) => prev.status != cur.status,
                  listener: (BuildContext context, LoginState state) {
                    if (state.status == FormzSubmissionStatus.success) {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.splashRoute);
                    } else {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                              content: Text(state.errorMessage ?? ''),
                              duration: Duration(
                                milliseconds: 1000,
                              )),
                        );
                    }
                  },
                );
              }),
            ),
            const SizedBox(
              height: 130,
            ),
            const Text('New User? Create Account')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          //
        },
        builder: (context, state) => _loginWidget(),
      );
}
