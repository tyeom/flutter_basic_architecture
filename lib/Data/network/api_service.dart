import 'package:basic_architecture/Data/network/api_endpoint.dart';
import 'package:basic_architecture/Data/responses/authentication_response.dart';
import 'package:basic_architecture/Data/responses/member_response.dart';
import 'package:basic_architecture/Data/responses/subscription_key_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart' as http;
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(final Dio dio) = _ApiService;

  /// 로그인 요청
  @POST("${ApiEndpoint.publicApi}/login")
  Future<AuthenticationResponse> login(
      @Field("Id") String id, @Field("Password") String password);

  /// 로그아웃 요청
  @GET("${ApiEndpoint.publicApi}/Logout")
  Future<void> logout();

  /// 회원 가입 요청
  @GET("${ApiEndpoint.publicApi}/Register")
  Future<String> register(
    @Field("id") String id,
    @Field("password") String password,
    @Field("role") int role,
    @Field("name") String name,
    @Field("email") String? email,
    @Field("tel") String? tel,
  );

  /// 유저 정보 요청
  @GET("${ApiEndpoint.privateApi}/MemberInfo")
  @http.Headers({'accessToken': 'true'})
  Future<MemberResponse> getMemberInfo();

  /// 구독 키 정보 정보 요청
  @GET("${ApiEndpoint.privateApi}/SubscriptionKey")
  @http.Headers({'accessToken': 'true'})
  Future<SubscriptionKeyResponse?> getSubscriptionKeyInfo();
}
