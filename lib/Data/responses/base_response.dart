import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "message")
  String? message;
}
