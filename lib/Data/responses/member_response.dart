import 'package:basic_architecture/Data/responses/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_response.g.dart';

/// 유저 정보 요청 응답
@JsonSerializable()
class MemberResponse extends BaseResponse {
  @JsonKey(name: "no")
  int no;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "role")
  int role;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "tel")
  String tel;
  @JsonKey(name: "subscriptionKeyNo")
  int? subscriptionKeyNo;

  MemberResponse(this.no, this.id, this.role, this.name, this.email, this.tel,
      this.subscriptionKeyNo);
  factory MemberResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$MemberResponseToJson(this);
}
