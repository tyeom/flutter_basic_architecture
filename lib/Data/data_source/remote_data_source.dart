import 'package:basic_architecture/Data/responses/authentication_response.dart';
import 'package:basic_architecture/Data/responses/member_response.dart';
import 'package:basic_architecture/Data/responses/sample_data_response.dart';
import 'package:basic_architecture/Data/responses/subscription_key_response.dart';
import 'package:basic_architecture/Domain/request/login_request.dart';
import 'package:basic_architecture/Domain/request/register_request.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<void> logout();
  Future<String> register(RegisterRequest registerRequest);
  Future<MemberResponse> getMemberInfo();
  Future<List<SampleDataResponse>> getSampleData();
  Future<SampleDataResponse> getDetailSampleData(int id);
  Future<SubscriptionKeyResponse?> getSubscriptionKeyResponse();
}
