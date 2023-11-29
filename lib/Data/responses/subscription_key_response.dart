import 'package:basic_architecture/Data/responses/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_key_response.g.dart';

/// 구독 키 정보 요청 응답
@JsonSerializable()
class SubscriptionKeyResponse extends BaseResponse {
  @JsonKey(name: "key")
  String key;
  @JsonKey(name: "keyType")
  String keyType;
  @JsonKey(name: "startDT")
  DateTime startDT;
  @JsonKey(name: "endDT")
  DateTime endDT;
  @JsonKey(name: "createDT")
  DateTime createDT;
  @JsonKey(name: "memo")
  String memo;

  SubscriptionKeyResponse(this.key, this.keyType, this.startDT, this.endDT,
      this.createDT, this.memo);
  factory SubscriptionKeyResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionKeyResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$SubscriptionKeyResponseToJson(this);
}
