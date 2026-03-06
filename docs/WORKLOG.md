# VTrace 변경 이력 (WORKLOG)

최신 작업 내역이 상단에 위치합니다.

## 2026-03-06 (인증 UI 개선 및 Mock 로그인 고도화)

### 변경 사항
- **로그인 Mock 연동**: 아직 API가 개발되지 않은 점을 감안하여 `Test@Test` / `aaaaaaaaA!` 계정으로만 로그인이 허용되도록 `AuthRepositoryImpl` 의 Mock 로직을 구체화했습니다.
- **로그인 오류 UI 개선**: 로그인 화면의 Email 및 비밀번호 입력란에서 텍스트 입력 시 나타나던 초록색 '성공' 체크 아이콘이 보이지 않도록 수정했습니다. (회원가입 화면은 기존 유지)
- **회원가입 인증 타이머 추가**: 이메일 입력란 우측에 "인증" 버튼을 배치하고, 해당 버튼 클릭 시 5분(300초) 카운트다운 타이머가 "인증코드 입력" 란 우측에 나타나 동작하도록 `SignUpViewModel` 에 Timer 상태를 연동했습니다.

### 변경 이유
- 백엔드 미구현 상태에서 클라이언트 단의 요구사항(특정 계정 제한, UI 디테일 조정)을 임시 반영하고, 이메일 인증 절차의 사용자 경험을 프로토타이핑(Prototyping)하기 위함입니다.

### 실행 순서
1. `AuthRepositoryImpl` 의 `login()` 함수에 특정 계정 하드코딩 검증 추가
2. `LoginScreen` 내 `VTraceTextField` 컴포넌트의 `isSuccess` 속성 제거
3. `SignUpState` 에 `timerSeconds`, `isCodeSent` 상태 프로퍼티 속성 추가 및 `SignUpViewModel` 내부 Timer 로직 구성
4. `SignUpScreen` 내 이메일 입력란과 인증코드 입력란을 `Row` 로 감싸 인증 요청 버튼과 Timer UI 를 삽입
5. `WORKLOG.md` 에 변경 이력 기록

### 수정 혹은 추가된 파일 경로
- `/lib/data/repositories/auth_repository_impl.dart`
- `/lib/feature/auth/presentation/widgets/login_screen.dart`
- `/lib/feature/auth/presentation/viewmodel/signup_viewmodel.dart`
- `/lib/feature/auth/presentation/widgets/signup_screen.dart`

### 검증 방법
- 앱을 실행하여 로그인 화면에서 `Test@Test` / `aaaaaaaaA!` 로 로그인 시 정상동작 여부 확인, 타 계정 시도 시 에러 Toast 확인.
- 로그인 화면 입력 필드 우측에 초록 마크가 뜨지 않는지 확인.
- 회원가입 화면에서 이메일 필드에 정상적인 텍스트 입력 후 "인증" 버튼 활성화 시점 확인.
- "인증" 버튼 클릭 시, 05:00 부터 타이머가 감소하는지 확인.

---
## 2026-03-06 (Gitignore 업데이트)

### 변경 사항
- 전역 `.gitignore` 파일을 Flutter 프로젝트 정석(표준)에 맞게 업데이트했습니다.

### 변경 이유
- 불필요한 빌드 파일(`.gradle`, `local.properties`, `Pods` 등), 환경 변수(`.env`), 보안 설정 파일(`*.jks`), 그리고 각종 IDE 구성 파일들이 Git 버전에 추적되지 않도록 제외하여 프로젝트 무결성을 유지하고 보안 취약점을 예방하기 위함입니다.

### 실행 순서
1. `/.gitignore` 파일에 안드로이드 타겟 생태계 파일, iOS Pods 캐시, 주요 플랫폼별 임시 빌드 폴더, `.env`, `.idea/`, `.vscode/` 무시 룰을 추가 반영
2. `WORKLOG.md` 에 Gitignore 수정 내역 기록

### 수정 혹은 추가된 파일 경로
- `/.gitignore`

### 검증 방법
- `git status` 명령어를 실행하여 제외 처리된 빌드 폴더 및 로컬 설정(예: `local.properties` 등)이 untracked 목록에 더이상 나타나지 않는지 확인합니다.

---

## 2026-03-06 (인증 기능 구현: 로그인 및 회원가입)

### 변경 사항
- **UI & Design System**: 공용 위젯인 `VTraceTextField` 및 `VTraceButton` 생성
- **Domain & Data 계층**: 인증 도메인 모델(`AuthUser`), 레포지토리 인터페이스 정의 및 Mock 구현체(`AuthRepositoryImpl`) 작성
- **Presentation 계층**: Riverpod과 연동된 로그인 화면(`LoginScreen`, `LoginViewModel`) 및 회원가입 화면(`SignUpScreen`, `SignUpViewModel`) 구현. 이메일/비밀번호 정규식 유효성 검사 및 Toast 에러 표시 연동
- **라우팅**: 앱 실행 시 첫 구동 화면을 `/login`으로 설정하고 회원가입 라우트 연동
- `fluttertoast` 플러그인 추가

### 변경 이유
- `auth_requirement.md` 문서의 요구사항에 따라 로그인 및 회원가입 시 에러 검증, 로딩 상태 표시, 입력 필드 커스텀 뷰(에러 시 빨간 테두리, 일치 시 초록 V) 기능을 반영하기 위함입니다. 백엔드 연동 정보가 없어 임시 Mock 통신으로 설계했습니다.

### 실행 순서
1. `fluttertoast` 의존성 추가
2. 커스텀 TextField 및 Button 디자인 뷰 컴포넌트 추가
3. `auth_repository.dart` 및 Mock 레포지토리 구축
4. `LoginViewModel` 과 `LoginScreen` 작성
5. `SignUpViewModel` 과 `SignUpScreen` 작성
6. `app_router.dart` 의 라우트를 인증 초기 화면으로 변경
7. `build_runner` 를 통해 provider 및 제네릭 상태 생성 완료

### 수정 혹은 추가된 파일 경로
- `/lib/core/design_system/widgets/vtrace_textfield.dart` [NEW]
- `/lib/core/design_system/widgets/vtrace_button.dart` [NEW]
- `/lib/domain/models/auth_user.dart` [NEW]
- `/lib/domain/repositories/auth_repository.dart` [NEW]
- `/lib/data/repositories/auth_repository_impl.dart` [NEW]
- `/lib/feature/auth/presentation/viewmodel/login_viewmodel.dart` [NEW]
- `/lib/feature/auth/presentation/widgets/login_screen.dart` [NEW]
- `/lib/feature/auth/presentation/viewmodel/signup_viewmodel.dart` [NEW]
- `/lib/feature/auth/presentation/widgets/signup_screen.dart` [NEW]
- `/lib/router/app_router.dart`
- `/pubspec.yaml`

---

## 2026-03-06 (초기 스켈레톤 아키텍처 및 의존성 구성)

### 변경 사항
- `pubspec.yaml`를 수정하여 앱에 필요한 플러그인(`riverpod`, `dio`, `drift`, `go_router` 등) 추가
- 안드로이드 `compileSdk` 설정 및 외부 공유 Intent(`receive_sharing_intent`) 처리를 위한 `AndroidManifest.xml` 업데이트 (iOS 설정 생략)
- 앱 초기 진입점(`main.dart`)을 `ProviderScope`와 `go_router`를 이용하도록 모두 재작성
- `lib/core/network` 레이어 구축(`dio_client.dart`, `interceptors.dart`, `network_exception.dart`)
- `lib/core/common/logger` 등 전역 로깅 체계 구현
- `docs/` 디렉토리에 필수 문서인 README, DECISIONS, WORKLOG 파일 생성

### 변경 이유
- 프로젝트 글로벌 룰(Clean Architecture, 17 Java Version 등)과 `project_requirement.md` 문서에 기반하여 앱의 뼈대와 핵심 인프라를 마련하기 위해서입니다. 
- Windows 환경에서 수행되었기 때문에 iOS 전용 설정(`Podfile`, `Info.plist` 공유 확장 기능 등)은 보류되었습니다.

### 실행 순서
1. `build.gradle.kts` SDK 버전 26~36 설정
2. `pubspec.yaml` 패키지 추가 및 `flutter pub get`
3. `Network`, `Logger`, `Router`, `Home` 화면으로 구성된 Clean Architecture 계층 구조 스켈레톤 폴더/파일 추가
4. `main.dart`에 `MaterialApp.router` 구성 및 `ProviderScope` 연동
5. `flutter pub run build_runner build -d`로 Riverpod/Json 코드 재생성
6. `AndroidManifest.xml`에 `text/plain` 타입 데이터를 받을 수 있는 `SEND` 인텐트 필터 추가 
7. DOcumentation 정리

### 수정된 파일 경로
- `/android/app/build.gradle.kts`
- `/pubspec.yaml`
- `/lib/main.dart`
- `/lib/core/common/logger/app_logger.dart` [NEW]
- `/lib/core/network/exceptions/network_exception.dart` [NEW]
- `/lib/core/network/client/interceptors.dart` [NEW]
- `/lib/core/network/client/dio_client.dart` [NEW]
- `/lib/core/network/di/network_module.dart` [NEW]
- `/lib/feature/home/presentation/widgets/home_screen.dart` [NEW]
- `/lib/router/app_router.dart` [NEW]
- `/android/app/src/main/AndroidManifest.xml`
- `/docs/README.md` [NEW]
- `/docs/WORKLOG.md` [NEW]
- `/docs/DECISIONS.md` [NEW]

### 검증 방법
- `flutter build apk` 혹은 `flutter run` 을 통해 안드로이드 기기 또는 에뮬레이터에서 앱이 성공적으로 실행되고 홈 화면(`VTrace Home`)만 표시되는지 확인합니다.
- 외부 안드로이드 앱에서 "공유" 를 눌러 텍스트/URL을 넘길 때 VTrace가 앱 목록에 표시되는지 확인합니다.
