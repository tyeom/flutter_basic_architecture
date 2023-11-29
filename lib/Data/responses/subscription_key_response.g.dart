// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_key_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionKeyResponse _$SubscriptionKeyResponseFromJson(
        Map<String, dynamic> json) =>
    SubscriptionKeyResponse(
      json['key'] as String,
      json['keyType'] as String,
      DateTime.parse(json['startDT'] as String),
      DateTime.parse(json['endDT'] as String),
      DateTime.parse(json['createDT'] as String),
      json['memo'] as String,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SubscriptionKeyResponseToJson(
        SubscriptionKeyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'key': instance.key,
      'keyType': instance.keyType,
      'startDT': instance.startDT.toIso8601String(),
      'endDT': instance.endDT.toIso8601String(),
      'createDT': instance.createDT.toIso8601String(),
      'memo': instance.memo,
    };
