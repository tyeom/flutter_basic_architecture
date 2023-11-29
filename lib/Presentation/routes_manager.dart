import 'package:basic_architecture/Injectable/configurations.dart';
import 'package:basic_architecture/Presentation/authentication/bloc/authentication_bloc.dart';
import 'package:basic_architecture/Presentation/home/view/app_view.dart';
import 'package:basic_architecture/Presentation/login/bloc/login_bloc.dart';
import 'package:basic_architecture/Presentation/login/view/login_view.dart';
import 'package:basic_architecture/Presentation/splash/splash.dart';
import 'package:basic_architecture/Presentation/subscription_info/bloc/subscription_info_bloc.dart';
import 'package:basic_architecture/Presentation/subscription_info/view/subscription_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String loginRoute = "/login";
  static const String mainRoute = "/main";
  static const String subscriptionKeyInfoRoute = "/subscriptionKeyInfo";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        var authBloc = getIt<AuthenticationBloc>();
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: authBloc,
                  child: const SplashView(),
                ));
      case Routes.loginRoute:
        var loginBloc = getIt<LoginBloc>();
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: loginBloc,
                  child: const LoginView(),
                ));
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const AppView());
      case Routes.subscriptionKeyInfoRoute:
        var subscriptionInfoBloc = getIt<SubscriptionInfoBloc>();
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: subscriptionInfoBloc,
                  child: const SubscriptionInfoView(),
                ));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  "찾을 수 없는 페이지 (page not found)",
                ),
              ),
              body: const Center(
                child: Text("찾을 수 없는 페이지 (page not found)"),
              ),
            ));
  }
}
