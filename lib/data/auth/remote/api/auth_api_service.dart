import 'package:dio/dio.dart';

import '../dto/auth_response_dto.dart';
import '../dto/email_code_request_dto.dart';
import '../dto/login_request_dto.dart';
import '../dto/register_request_dto.dart';

/// 인증 관련 HTTP 엔드포인트를 호출하는 API 서비스입니다.
///
/// 실제 백엔드 API 명세 확정 후 본 클래스의 호출 시그니처를 그에 맞춰 조정합니다.
class AuthApiService {
  final Dio _dio;

  /// [AuthApiService] 객체를 생성합니다.
  ///
  /// [dio] 외부에서 주입받는 Dio 인스턴스
  const AuthApiService(this._dio);

  /// 로그인 API 를 호출합니다.
  ///
  /// [request] 로그인 요청 DTO
  /// 반환값은 응답으로 받은 [AuthResponseDto] 객체입니다.
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    final response = await _dio.post(
      '/auth/login',
      data: request.toJson(),
    );
    return AuthResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  /// 회원가입 API 를 호출합니다.
  ///
  /// [request] 회원가입 요청 DTO
  /// 반환값은 응답으로 받은 [AuthResponseDto] 객체입니다.
  Future<AuthResponseDto> register(RegisterRequestDto request) async {
    final response = await _dio.post(
      '/auth/register',
      data: request.toJson(),
    );
    return AuthResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  /// 이메일 인증 코드 발송 API 를 호출합니다.
  ///
  /// [request] 발송 요청 DTO
  Future<void> sendEmailCode(EmailCodeRequestDto request) async {
    await _dio.post('/auth/email-code/send', data: request.toJson());
  }

  /// 이메일 인증 코드 검증 API 를 호출합니다.
  ///
  /// [request] 검증 요청 DTO
  /// 반환값은 검증 성공 여부입니다.
  Future<bool> verifyEmailCode(EmailCodeRequestDto request) async {
    final response = await _dio.post(
      '/auth/email-code/verify',
      data: request.toJson(),
    );
    final data = response.data as Map<String, dynamic>;
    return (data['verified'] as bool?) ?? false;
  }

  /// 비밀번호 재설정 코드 발송 API 를 호출합니다.
  ///
  /// [request] 발송 요청 DTO
  Future<void> sendPasswordResetCode(EmailCodeRequestDto request) async {
    await _dio.post(
      '/auth/password-reset/send',
      data: request.toJson(),
    );
  }
}
