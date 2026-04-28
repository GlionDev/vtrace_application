// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_code_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailCodeRequestDto _$EmailCodeRequestDtoFromJson(Map<String, dynamic> json) =>
    EmailCodeRequestDto(
      email: json['email'] as String,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$EmailCodeRequestDtoToJson(
  EmailCodeRequestDto instance,
) => <String, dynamic>{'email': instance.email, 'code': instance.code};
