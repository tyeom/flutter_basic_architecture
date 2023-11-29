// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberResponse _$MemberResponseFromJson(Map<String, dynamic> json) =>
    MemberResponse(
      json['no'] as int,
      json['id'] as String,
      json['role'] as int,
      json['name'] as String,
      json['email'] as String,
      json['tel'] as String,
      json['subscriptionKeyNo'] as int?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$MemberResponseToJson(MemberResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'no': instance.no,
      'id': instance.id,
      'role': instance.role,
      'name': instance.name,
      'email': instance.email,
      'tel': instance.tel,
      'subscriptionKeyNo': instance.subscriptionKeyNo,
    };
