import 'package:json_annotation/json_annotation.dart';

part 'auth_response_dto.g.dart';

/// 로그인/회원가입 응답에 공통적으로 사용되는 DTO 입니다.
@JsonSerializable()
class AuthResponseDto {
  /// 사용자 고유 ID
  final String id;

  /// 사용자 이메일
  final String email;

  /// 발급된 액세스 토큰
  final String token;

  /// [AuthResponseDto] 객체를 생성합니다.
  ///
  /// [id] 사용자 ID
  /// [email] 사용자 이메일
  /// [token] 발급된 액세스 토큰
  const AuthResponseDto({
    required this.id,
    required this.email,
    required this.token,
  });

  /// JSON 으로부터 [AuthResponseDto] 인스턴스를 생성합니다.
  ///
  /// [json] 변환할 JSON 맵
  /// 반환값은 변환된 DTO 객체입니다.
  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);

  /// DTO 를 JSON 맵으로 직렬화합니다.
  ///
  /// 반환값은 직렬화된 JSON 맵입니다.
  Map<String, dynamic> toJson() => _$AuthResponseDtoToJson(this);
}
