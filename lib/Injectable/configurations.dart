import 'package:basic_architecture/App/app_preferences.dart';
import 'package:basic_architecture/Data/data_source/remote_data_source.dart';
import 'package:basic_architecture/Data/data_source/remote_data_source_imp.dart';
import 'package:basic_architecture/Data/network/api_client.dart';
import 'package:basic_architecture/Data/network/api_provider.dart';
import 'package:basic_architecture/Data/network/api_sanple_data_service.dart';
import 'package:basic_architecture/Data/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configurations.config.dart' as config;

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() => $initGetIt(getIt);

Future<void> $initGetIt(
  GetIt getIt, {
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  final gh = GetItHelper(getIt, environment.toString());
  final sharedPreferences = await SharedPreferences.getInstance();

  // IoC 등록
  gh.lazySingleton<AppPreferences>(() => AppPreferences(sharedPreferences));

  // Http 요청 처리 등록
  var baseApiClient = ApiClient(ApiType.base, enableLogging: true);

  // Dio 등록 [ApiClient에서 생성한 apiProvider가 가지고 있는 Dio]
  gh.factory<Dio>(() => baseApiClient.apiProvider.getDio);

  // 실제 RestFul API 처리 서비스 등록
  gh.factory<ApiService>(() => ApiService(getIt<Dio>()));

  // 샘플 RestFul API 처리 서비스 등록
  var sampleDataApiClient = ApiClient(ApiType.sampleData, enableLogging: true);
  gh.factory<ApiSampleDataService>(
      () => ApiSampleDataService(sampleDataApiClient.apiProvider.getDio));

  //  RestFul API 서비스를 사용하는 원격 데이터 소스
  gh.factory<RemoteDataSource>(() =>
      RemoteDataSourceImp(getIt<ApiService>(), getIt<ApiSampleDataService>()));

  config.$initGetIt(getIt);
}
