# VTrace

오디오/미디어를 분리 및 파일로 추출하는 VTrace 어플리케이션입니다.

## 아키텍처
Clean Architecture 패턴과 MVVM(Riverpod 기반)을 사용합니다.
단, 소규모 앱으로서 `DataSource` 계층은 생략되어 있으며, `Repository`에서 직접 `ApiService`를 호출하여 응답을 검증하고 도메인 모델로 매핑합니다.

## 개발 설정 사항
- **Language**: Kotlin 1.17+ / Dart 3+
- **Framework**: Flutter (Material 3)
- **Local Database**: Drift (SQLite)
- **Storage**: SharedPreferences & FlutterSecureStorage
- **State Management**: Riverpod
- **Routing**: go_router
- **Network**: Dio (+ json_serializable)

## 빌드 및 실행 방법

1. 의존성 설치
```bash
flutter pub get
```

2. Riverpod, Drift 등 코드 젠 실행 (필요 시)
```bash
flutter pub run build_runner build -d
```

3. 안드로이드 / iOS 빌드
```bash
flutter run
```
