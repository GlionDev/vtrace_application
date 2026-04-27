import 'package:json_annotation/json_annotation.dart';

part 'login_request_dto.g.dart';

/// 로그인 요청에 사용되는 DTO 입니다.
@JsonSerializable()
class LoginRequestDto {
  /// 로그인 이메일
  final String email;

  /// 로그인 비밀번호
  final String password;

  /// [LoginRequestDto] 객체를 생성합니다.
  ///
  /// [email] 로그인 이메일
  /// [password] 로그인 비밀번호
  const LoginRequestDto({required this.email, required this.password});

  /// JSON 으로부터 [LoginRequestDto] 인스턴스를 생성합니다.
  ///
  /// [json] 변환할 JSON 맵
  /// 반환값은 변환된 DTO 객체입니다.
  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);

  /// DTO 를 JSON 맵으로 직렬화합니다.
  ///
  /// 반환값은 직렬화된 JSON 맵입니다.
  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);
}
