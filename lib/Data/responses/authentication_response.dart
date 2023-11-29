import 'package:basic_architecture/Data/responses/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_response.g.dart';

/// 로그인 요청 응답
@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "token")
  String token;
  @JsonKey(name: "expiration")
  DateTime expiration;

  AuthenticationResponse(this.token, this.expiration);
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$AuthenticationResponseToJson(this);
}
