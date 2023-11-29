import 'package:basic_architecture/Data/data_source/remote_data_source.dart';
import 'package:basic_architecture/Data/network/api_sanple_data_service.dart';
import 'package:basic_architecture/Data/network/api_service.dart';
import 'package:basic_architecture/Data/responses/authentication_response.dart';
import 'package:basic_architecture/Data/responses/member_response.dart';
import 'package:basic_architecture/Data/responses/sample_data_response.dart';
import 'package:basic_architecture/Data/responses/subscription_key_response.dart';
import 'package:basic_architecture/Domain/request/login_request.dart';
import 'package:basic_architecture/Domain/request/register_request.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final ApiService _apiService;
  final ApiSampleDataService _apiSampleDataService;

  RemoteDataSourceImp(this._apiService, this._apiSampleDataService);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _apiService.login(loginRequest.id, loginRequest.password);
  }

  @override
  Future<void> logout() async {
    return await _apiService.logout();
  }

  @override
  Future<String> register(RegisterRequest registerRequest) async {
    return await _apiService.register(
        registerRequest.id,
        registerRequest.password,
        registerRequest.role,
        registerRequest.name,
        registerRequest.email,
        registerRequest.tel);
  }

  @override
  Future<MemberResponse> getMemberInfo() async {
    return await _apiService.getMemberInfo();
  }

  @override
  Future<List<SampleDataResponse>> getSampleData() async {
    return await _apiSampleDataService.getSampleData();
  }

  @override
  Future<SampleDataResponse> getDetailSampleData(int id) async {
    return await _apiSampleDataService.getDetailSampleData(id);
  }

  @override
  Future<SubscriptionKeyResponse?> getSubscriptionKeyResponse() async {
    return await _apiService.getSubscriptionKeyInfo();
  }
}
