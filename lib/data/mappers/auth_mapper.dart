import '../../domain/models/auth_model.dart';
import '../auth/remote/dto/auth_response_dto.dart';

/// [AuthResponseDto] ↔ 도메인 모델 매핑 확장입니다.
extension AuthResponseDtoMapper on AuthResponseDto {
  /// 응답 DTO 를 도메인 모델 [AuthUser] 로 변환합니다.
  ///
  /// 반환값은 변환된 [AuthUser] 객체입니다.
  AuthUser toDomain() => AuthUser(id: id, email: email, token: token);
}
