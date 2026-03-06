# VTrace 변경 이력 (WORKLOG)

최신 작업 내역이 상단에 위치합니다.

## 2026-03-06 (로그인 비밀번호 힌트 제거 및 홈 화면 권한 요청 로직 보완)

### 변경 사항
- **로그인 정책 변경**: 로그인 시 패스워드 입력란에서 대소문자/특수문자 등 정규식 힌트가 나타나지 않도록 `LoginViewModel`의 검증 로직을 제거했습니다.
- **가져오기 권한 위임 가이드 추가**: 홈 화면에서 "내 파일에서 가져오기" 클릭 시 파일 접근(Storage/Audio) 권한을 요청하며, 권한 거절 시 Toast 메시지("해당 기능을 이용하기 위해 권한을 허용해주세요")를 출력하고 영구 거절 시 설정 화면으로 유도하는 안내 Dialog를 띄우도록 `HomeScreen` 로직을 보완했습니다.

### 변경 이유
- 사용자 피드백(요구사항)에 따라 로그인 시 불필요한 비밀번호 정규식 힌트를 노출하지 않기 위함입니다.
- 안드로이드 OS의 권한(Permission) 정책에 대응하여, 사용자가 권한을 한 번 혹은 여러 번 거부했을 때 어떤 조치를 취해야 하는지 명확히 안내하여 UX 편의성을 개선하기 위함입니다.

### 실행 순서
1. `login_viewmodel.dart` 의 `onPasswordChanged` 내 정규식 에러 처리 로직 제거
2. `home_screen.dart` 의 `_pickFile()` 함수 내에 `permission_handler` 로직 고도화 (Storage 및 Audio 권한 복합 확인)
3. 권한 일반 거부 시 `fluttertoast`를 이용해 안내 메시지 노출
4. 권한 영구 거부 시 `AlertDialog` 및 `openAppSettings()`를 이용해 설정 화면 이동 유도 처리
5. `WORKLOG.md` 에 변경 이력 추가

### 수정 혹은 추가된 파일 경로
- `/lib/feature/auth/presentation/viewmodel/login_viewmodel.dart`
- `/lib/feature/home/presentation/widgets/home_screen.dart`
- `/docs/WORKLOG.md`

### 검증 방법
- 로그인 화면에서 비밀번호 입력 시 하단에 '대소문자, 특수문자 포함 10자리 이상...' 에러 힌트가 표시되지 않는지 확인합니다.
- 홈 화면의 첫 번째 탭에서 '파일 가져오기' 버튼을 클릭한 뒤 권한을 거절하고 다시 눌렀을 때의 Toast 문구와 영구 거절 시 뜨는 Dialog 작동 여부를 확인합니다.

---

## 2026-03-06 (홈 화면 코어 레이아웃 및 파일/링크 접근 기능 구현)

### 변경 사항
- **라이브러리 추가**: 파일 접근을 위한 `file_picker` 와 런타임 권한 요청을 위한 `permission_handler` 플러그인을 `pubspec.yaml` 에 추가했습니다.
- **안드로이드 권한 설정**: 안드로이드 기기에서의 파일 읽기 권한 처리를 위해 `AndroidManifest.xml` 내에 `READ_EXTERNAL_STORAGE` 및 `READ_MEDIA_*` 권한을 추가했습니다.
- **홈 화면 UI(Tabs) 구성**: 요구사항에 따라 화면 상단에는 남은 크레딧(무료 횟수 1/1)을 전시하고 중앙에는 "내 파일에서 가져오기" 와 "링크로 가져오기" 2개의 탭이 나타나도록 `HomeScreen` 을 구성했습니다.
- **파일 가져오기 로직 연동**: "내 파일에서 가져오기" 탭에서 파일 선택 전 OS 권한을 묻고, 승인 시 오디오 파일을 선택하여 경로명(`HomeState` 의 `selectedFilePath`)이 UI 에 나타나도록 연동했습니다.
- **링크로 가져오기 로직 연동**: URL 링크를 입력하는 텍스트 필드와 "분리" 버튼을 추가했으며, 분리 클릭 시 2초간 `HomeViewModel` 타이머 로직이 동작하고 크레딧이 1 차감되도록 모의(Mock) 연결했습니다.

### 변경 이유
- `home_requirement.md` 문서 내 유튜브 외부 공유(`receive_sharing_intent`) 기능을 제외한 모든 기능을 MVP 스펙으로 선 반영하기 위함입니다. API 가 현재 미구축되어 있어 API 연동 부는 딜레이 타이머로 데모 구현했습니다.

### 실행 순서
1. `file_picker`, `permission_handler` 패키지 추가 후 의존성 동기화
2. 안드로이드 플랫폼 매니페스트 저장소 권한 명시
3. 상태 저장을 위한 `HomeState` 및 `HomeViewModel` 생성
4. `TabController` 및 `TabBarView` 를 이용한 홈 화면 디자인
5. 각 탭 내부 기능(파일 선택/링크 추출)과 뷰모델 이펙트 통합
6. 코드 제너레이터(`build_runner`) 재실행하여 Provider 생성
7. `WORKLOG.md` 에 기록 추가

### 수정 혹은 추가된 파일 경로
- `/pubspec.yaml`
- `/android/app/src/main/AndroidManifest.xml`
- `/lib/feature/home/presentation/viewmodel/home_viewmodel.dart` [NEW]
- `/lib/feature/home/presentation/widgets/home_screen.dart`

### 검증 방법
- `flutter run` 으로 실행 후 홈 화면 상단의 크레딧 문구와 2개의 탭 내비게이션 전환이 정상 동작하는지 확인합니다.
- 첫번째 탭에서 파일 가져오기를 누를 시 권한 프롬프트가 나타나고, 이후 오디오 파일을 선택할 수 있는지 확인합니다.
- 두번째 탭에서 '분리' 버튼을 누르면 크레딧 횟수가 감소하는지 확인합니다.

---
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
