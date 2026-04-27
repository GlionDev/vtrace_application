import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/send_email_verification_code_usecase.dart';
import '../../domain/usecases/send_password_reset_code_usecase.dart';
import '../../domain/usecases/verify_email_code_usecase.dart';
import '../auth/di/auth_data_module.dart';

part 'auth_usecase_module.g.dart';

/// 로그인 UseCase 를 제공합니다.
///
/// 반환값은 [LoginUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
Future<LoginUseCase> loginUseCase(Ref ref) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return LoginUseCase(repo);
}

/// 회원가입 UseCase 를 제공합니다.
///
/// 반환값은 [RegisterUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
Future<RegisterUseCase> registerUseCase(Ref ref) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return RegisterUseCase(repo);
}

/// 이메일 인증 코드 발송 UseCase 를 제공합니다.
///
/// 반환값은 [SendEmailVerificationCodeUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
Future<SendEmailVerificationCodeUseCase> sendEmailVerificationCodeUseCase(
  Ref ref,
) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return SendEmailVerificationCodeUseCase(repo);
}

/// 이메일 인증 코드 검증 UseCase 를 제공합니다.
///
/// 반환값은 [VerifyEmailCodeUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
Future<VerifyEmailCodeUseCase> verifyEmailCodeUseCase(Ref ref) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return VerifyEmailCodeUseCase(repo);
}

/// 비밀번호 재설정 코드 발송 UseCase 를 제공합니다.
///
/// 반환값은 [SendPasswordResetCodeUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
Future<SendPasswordResetCodeUseCase> sendPasswordResetCodeUseCase(
  Ref ref,
) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return SendPasswordResetCodeUseCase(repo);
}
