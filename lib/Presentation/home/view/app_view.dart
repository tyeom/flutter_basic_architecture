import 'package:basic_architecture/Injectable/configurations.dart';
import 'package:basic_architecture/Presentation/authentication/bloc/authentication_bloc.dart';
import 'package:basic_architecture/Presentation/home/bloc/sample_data_bloc.dart';
import 'package:basic_architecture/Presentation/home/view/desktop_home_view.dart';
import 'package:basic_architecture/Presentation/home/view/mobile_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  final Widget mobileView = const MobileView();
  final Widget desktopView = const DesktopHomeView();
  static const int _maxWidth = 900;

  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<SampleDataBloc>(
            create: (context) => getIt<SampleDataBloc>()
              ..add(
                GetSampleDataListEvent(),
              ),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => getIt<AuthenticationBloc>(),
          ),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < _maxWidth) {
              return mobileView;
            } else {
              return desktopView;
            }
          },
        ),
      );

  // @override
  // Widget build(BuildContext context) {
  //   return LayoutBuilder(builder: (context, constraints) {
  //     if (constraints.maxWidth < _maxWidth) {
  //       return mobileView;
  //     } else {
  //       return desktopView;
  //     }
  //   });
  // }
}
