import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_module.g.dart';

/// 토큰 등 민감한 데이터를 저장하기 위한 [FlutterSecureStorage] 인스턴스를 제공합니다.
///
/// 반환값은 보안 키체인/Keystore 에 접근할 수 있는 스토리지 객체입니다.
@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}
