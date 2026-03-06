import 'package:dio/dio.dart';
import '../../common/logger/app_logger.dart';

/// API 요청 및 응답 로그를 출력하는 인터셉터입니다.
class LoggingInterceptor extends Interceptor {
  final _logger = AppLogger.getLogger('Network');

  /// API 요청 전 로그를 기록합니다.
  ///
  /// [options] 요청 옵션 정보
  /// [handler] 다음 인터셉터 수행을 위한 핸들러
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  /// API 정상 응답 수신 후 로그를 기록합니다.
  ///
  /// [response] 수신한 응답 객체
  /// [handler] 다음 인터셉터 수행을 위한 핸들러
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  /// API 호출 에러 시 로그를 기록합니다.
  ///
  /// [err] 발생한 DioException
  /// [handler] 다음 인터셉터 수행을 위한 핸들러
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.severe(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}

/// 인증 관련 헤더를 추가하는 인터셉터입니다.
class TokenInterceptor extends Interceptor {
  /// API 요청에 필요한 인증 정보를 헤더에 포함시킵니다.
  ///
  /// [options] 요청 옵션 정보
  /// [handler] 다음 인터셉터 수행을 위한 핸들러
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: 서버 설정에 맞는 토큰 로직 주입
    super.onRequest(options, handler);
  }
}
