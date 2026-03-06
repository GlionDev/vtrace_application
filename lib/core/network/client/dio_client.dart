import 'package:dio/dio.dart';
import 'interceptors.dart';

/// 앱 전반에서 사용할 Dio 클라이언트를 구성하는 클래스입니다.
class DioClient {
  final Dio _dio;

  /// [DioClient] 인스턴스를 초기화하고 기본 옵션 및 인터셉터를 설정합니다.
  DioClient()
    : _dio = Dio(
        BaseOptions(
          // TODO: 환경에 따른 baseUrl 동적 설정 (dev/prod 등)
          baseUrl: 'https://example.com/api',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.addAll([TokenInterceptor(), LoggingInterceptor()]);
  }

  /// 설정이 완료된 [Dio] 객체를 반환합니다.
  Dio get dio => _dio;
}
