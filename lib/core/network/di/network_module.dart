import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../env/di/env_module.dart';
import '../client/dio_client.dart';

part 'network_module.g.dart';

/// 앱 내에서 전역으로 사용할 [Dio] 인스턴스를 제공하는 프로바이더입니다.
///
/// Riverpod DI를 통해 각 DataSource 에 HTTP 클라이언트를 주입할 때 사용됩니다.
/// 반환값은 환경 설정에 맞춰 구성된 [Dio] 객체입니다.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final env = ref.watch(appEnvProvider);
  return DioClient(env).dio;
}
