import 'package:json_annotation/json_annotation.dart';

part 'email_code_request_dto.g.dart';

/// 이메일 인증 코드 발송/검증 요청 DTO 입니다.
@JsonSerializable()
class EmailCodeRequestDto {
  /// 대상 이메일 주소
  final String email;

  /// 검증용 코드 값 (발송 요청 시 null)
  final String? code;

  /// [EmailCodeRequestDto] 객체를 생성합니다.
  ///
  /// [email] 대상 이메일
  /// [code] 검증 코드 (검증 요청 시에만 필요)
  const EmailCodeRequestDto({required this.email, this.code});

  /// JSON 으로부터 [EmailCodeRequestDto] 인스턴스를 생성합니다.
  ///
  /// [json] 변환할 JSON 맵
  /// 반환값은 변환된 DTO 객체입니다.
  factory EmailCodeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EmailCodeRequestDtoFromJson(json);

  /// DTO 를 JSON 맵으로 직렬화합니다.
  ///
  /// 반환값은 직렬화된 JSON 맵입니다.
  Map<String, dynamic> toJson() => _$EmailCodeRequestDtoToJson(this);
}
