// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../App/app_preferences.dart' as _i16;
import '../Data/data_source/remote_data_source.dart' as _i5;
import '../Data/repository/authentication_repository_imp.dart' as _i4;
import '../Data/repository/member_repository_imp.dart' as _i9;
import '../Data/repository/sample_data_repository_imp.dart' as _i11;
import '../Domain/repository/authentication_repository.dart' as _i3;
import '../Domain/repository/member_repository.dart' as _i8;
import '../Domain/repository/sample_data_repository.dart' as _i10;
import '../Domain/usecase/detail_load_sample_data_usecase.dart' as _i13;
import '../Domain/usecase/load_sample_data_usecase.dart' as _i14;
import '../Domain/usecase/login_usecase.dart' as _i6;
import '../Domain/usecase/logout_usecase.dart' as _i7;
import '../Domain/usecase/member_info_usecase.dart' as _i17;
import '../Domain/usecase/subscription_key_info_usecase.dart' as _i12;
import '../Presentation/authentication/bloc/authentication_bloc.dart' as _i20;
import '../Presentation/home/bloc/sample_data_bloc.dart' as _i18;
import '../Presentation/login/bloc/login_bloc.dart' as _i15;
import '../Presentation/subscription_info/bloc/subscription_info_bloc.dart'
    as _i19;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AuthenticationRepository>(
      () => _i4.AuthenticationRepositoryImp(gh<_i5.RemoteDataSource>()));
  gh.factory<_i6.LoginUseCase>(
      () => _i6.LoginUseCase(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i7.LogoutUseCase>(
      () => _i7.LogoutUseCase(gh<_i3.AuthenticationRepository>()));
  gh.lazySingleton<_i8.MemberRepository>(
      () => _i9.MemberRepositoryImp(gh<_i5.RemoteDataSource>()));
  gh.lazySingleton<_i10.SampleDataRepository>(
      () => _i11.SampleDataRepositoryImp(gh<_i5.RemoteDataSource>()));
  gh.factory<_i12.SubscriptionKeyInfoUseCase>(
      () => _i12.SubscriptionKeyInfoUseCase(gh<_i8.MemberRepository>()));
  gh.factory<_i13.DetailLoadSampleDataUseCase>(
      () => _i13.DetailLoadSampleDataUseCase(gh<_i10.SampleDataRepository>()));
  gh.factory<_i14.LoadSampleDataUseCase>(
      () => _i14.LoadSampleDataUseCase(gh<_i10.SampleDataRepository>()));
  gh.factory<_i15.LoginBloc>(() => _i15.LoginBloc(
        gh<_i16.AppPreferences>(),
        gh<_i6.LoginUseCase>(),
      ));
  gh.factory<_i17.MemberInfoUseCase>(
      () => _i17.MemberInfoUseCase(gh<_i8.MemberRepository>()));
  gh.factory<_i18.SampleDataBloc>(() => _i18.SampleDataBloc(
        gh<_i16.AppPreferences>(),
        gh<_i14.LoadSampleDataUseCase>(),
        gh<_i13.DetailLoadSampleDataUseCase>(),
      ));
  gh.factory<_i19.SubscriptionInfoBloc>(() => _i19.SubscriptionInfoBloc(
        gh<_i16.AppPreferences>(),
        gh<_i12.SubscriptionKeyInfoUseCase>(),
      ));
  gh.factory<_i20.AuthenticationBloc>(() => _i20.AuthenticationBloc(
        gh<_i16.AppPreferences>(),
        gh<_i7.LogoutUseCase>(),
        gh<_i17.MemberInfoUseCase>(),
      ));
  return getIt;
}
