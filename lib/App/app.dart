import 'package:basic_architecture/Injectable/configurations.dart';
import 'package:basic_architecture/Presentation/authentication/bloc/authentication_bloc.dart';
import 'package:basic_architecture/Presentation/home/bloc/sample_data_bloc.dart';
import 'package:basic_architecture/Presentation/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:basic_architecture/config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) => getIt<AuthenticationBloc>()
                ..add(
                    AuthenticationStatusChanged(AuthenticationStatus.loading)),
            ),
          ],
          child: MaterialApp(
            title: 'Clean Architecture in Flutter Demo App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: Language.values.map((e) => e.locale).toList(),
            locale: Language.ko.locale,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
          ));
}
