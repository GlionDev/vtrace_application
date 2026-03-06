# 기술적 결정 사항 (DECISIONS)

## 1. DataSource 계층 생략
- **상황**: VTrace 는 단순한 형태의 소규모 앱 요구사항을 가지고 있으며, `project_requirement.md` 문서에서 `DataSource`를 거치지 않고 직접 구현할 것을 지시함.
- **결정**: `Data` 계층 생성 시 `datasources` 디렉토리 없이 `repositories` 만을 사용한다.
- **효과**: 불필요한 보일러플레이트 코드를 줄이고 `Repository` 레이어에서 API 통신 예외 점검 및 DTO-Domain 연산을 직접 다루어 생산성을 향상시킴.

## 2. Windows 빌드 환경에서의 iOS 설정 보류
- **상황**: 앱에 외부 공유 기능 타겟(Share Intent)을 추가해야 함. 이를 위해선 iOS의 App Group 및 Share Extension 설정이 필요함. 
- **결정**: 개발 환경이 Windows 이므로 iOS의 `Podfile` 초기화 및 XCode 기반 `Share Extension` 설정을 보류함.
- **효과**: 현재 안드로이드 우선으로 구조 및 환경을 확보하고 추후 맥OS 구축이나 XCode 엑세스가 가능할 때 보완 가능.

## 3. 네트워크 공통 모듈 구성
- **결정**: Dio Client 및 Token/Logging Interceptor 구축
- **이유**: 향후 API 통신 간 모든 Request / Response 로그를 가시화하고, 필요 시 중앙에서 엑세스 토큰을 안전하게 덧붙이기 위함. Riverpod Provider를 통해 (`network_module.dart`) 전역에서 의존성 주입 형태로 사용되도록 설계함.
