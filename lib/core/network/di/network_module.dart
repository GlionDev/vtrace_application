import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../client/dio_client.dart';

part 'network_module.g.dart';

/// 앱 내에서 전역으로 사용할 [Dio] 인스턴스를 제공하는 프로바이더입니다.
///
/// Riverpod DI를 통해 각 Repository에 HTTP 클라이언트를 주입할 때 사용됩니다.
/// 반환값은 설정이 완료된 [Dio] 객체입니다.
@riverpod
Dio dio(Ref ref) {
  return DioClient().dio;
}
