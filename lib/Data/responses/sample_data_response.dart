import 'package:basic_architecture/Data/responses/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sample_data_response.g.dart';

/// 유저 정보 요청 응답
@JsonSerializable()
class SampleDataResponse extends BaseResponse {
  @JsonKey(name: "userId")
  int userId;
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "body")
  String body;

  SampleDataResponse(this.userId, this.id, this.title, this.body);
  factory SampleDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SampleDataResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$SampleDataResponseToJson(this);
}
