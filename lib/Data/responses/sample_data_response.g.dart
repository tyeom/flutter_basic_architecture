// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SampleDataResponse _$SampleDataResponseFromJson(Map<String, dynamic> json) =>
    SampleDataResponse(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['body'] as String,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SampleDataResponseToJson(SampleDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
