import 'package:dio/dio.dart';

import '../../env/app_env.dart';
import 'interceptors.dart';

/// 앱 전반에서 사용할 Dio 클라이언트를 구성하는 클래스입니다.
class DioClient {
  final Dio _dio;

  /// [DioClient] 인스턴스를 초기화하고 기본 옵션 및 인터셉터를 설정합니다.
  ///
  /// [env] 환경 설정값(`baseUrl`, 타임아웃 등)을 제공합니다.
  DioClient(AppEnv env)
    : _dio = Dio(
        BaseOptions(
          baseUrl: env.baseUrl,
          connectTimeout: Duration(seconds: env.networkTimeoutSeconds),
          receiveTimeout: Duration(seconds: env.networkTimeoutSeconds),
        ),
      ) {
    _dio.interceptors.addAll([TokenInterceptor(), LoggingInterceptor()]);
  }

  /// 설정이 완료된 [Dio] 객체를 반환합니다.
  Dio get dio => _dio;
}
