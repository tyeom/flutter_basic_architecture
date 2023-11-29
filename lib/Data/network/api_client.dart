import 'package:basic_architecture/App/app_preferences.dart';
import 'package:basic_architecture/Data/network/api_endpoint.dart';
import 'package:basic_architecture/Data/network/api_provider.dart';

class ApiClient {
  final bool enableLogging;
  late final ApiProviderFactory apiProvider;

  ApiClient(ApiType apiType, {required this.enableLogging}) {
    apiProvider = ApiProviderFactory(apiType, enableLogging);
  }
}
