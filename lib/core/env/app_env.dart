/// 앱 빌드 환경(dev/staging/prod) 종류를 정의하는 열거형입니다.
enum AppFlavor { dev, staging, prod }

/// 앱 전반에서 참조하는 환경 설정 모델입니다.
///
/// baseUrl, secrets 등 환경별로 달라지는 값을 담습니다.
class AppEnv {
  /// 현재 빌드 플레이버
  final AppFlavor flavor;

  /// API base URL
  final String baseUrl;

  /// 네트워크 connect/receive 타임아웃 (초)
  final int networkTimeoutSeconds;

  /// [AppEnv] 객체를 생성합니다.
  ///
  /// [flavor] 빌드 플레이버
  /// [baseUrl] API base URL
  /// [networkTimeoutSeconds] 네트워크 타임아웃 (초 단위)
  const AppEnv({
    required this.flavor,
    required this.baseUrl,
    this.networkTimeoutSeconds = 10,
  });

  /// 개발 환경 기본값을 반환합니다.
  static const AppEnv dev = AppEnv(
    flavor: AppFlavor.dev,
    baseUrl: 'https://dev.api.vtrace.example.com',
  );

  /// 스테이징 환경 기본값을 반환합니다.
  static const AppEnv staging = AppEnv(
    flavor: AppFlavor.staging,
    baseUrl: 'https://staging.api.vtrace.example.com',
  );

  /// 운영 환경 기본값을 반환합니다.
  static const AppEnv prod = AppEnv(
    flavor: AppFlavor.prod,
    baseUrl: 'https://api.vtrace.example.com',
  );

  /// 컴파일 타임 정의(`--dart-define=FLAVOR=...`) 또는 기본값으로
  /// 현재 환경 객체를 결정합니다.
  ///
  /// 반환값은 결정된 [AppEnv] 인스턴스입니다.
  static AppEnv current() {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    switch (flavor) {
      case 'prod':
        return prod;
      case 'staging':
        return staging;
      case 'dev':
      default:
        return dev;
    }
  }
}
