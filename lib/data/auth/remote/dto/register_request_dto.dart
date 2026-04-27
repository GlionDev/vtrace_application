import 'package:json_annotation/json_annotation.dart';

part 'register_request_dto.g.dart';

/// 회원가입 요청에 사용되는 DTO 입니다.
@JsonSerializable()
class RegisterRequestDto {
  /// 가입 이메일
  final String email;

  /// 이메일 인증 코드
  final String code;

  /// 설정할 비밀번호
  final String password;

  /// [RegisterRequestDto] 객체를 생성합니다.
  ///
  /// [email] 가입 이메일
  /// [code] 인증 코드
  /// [password] 설정할 비밀번호
  const RegisterRequestDto({
    required this.email,
    required this.code,
    required this.password,
  });

  /// JSON 으로부터 [RegisterRequestDto] 인스턴스를 생성합니다.
  ///
  /// [json] 변환할 JSON 맵
  /// 반환값은 변환된 DTO 객체입니다.
  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);

  /// DTO 를 JSON 맵으로 직렬화합니다.
  ///
  /// 반환값은 직렬화된 JSON 맵입니다.
  Map<String, dynamic> toJson() => _$RegisterRequestDtoToJson(this);
}
