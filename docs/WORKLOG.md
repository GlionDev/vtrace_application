# VTrace 변경 이력 (WORKLOG)

최신 작업 내역이 상단에 위치합니다.

## 2026-03-09 (앱 최초 실행 시 들어온 공유 링크를 TextField 에 자동 입력하도록 개선)

### 변경 사항
- **글로벌 상태 초기화 방식 변경**: `main.dart`에서 `sharedTextProvider`의 초기값을 다룰 때, 강제 `overrideWith` 대신 전역 변수 `initialSharedText`를 선언하고 `SharedTextNotifier.build()` 함수가 이를 바라보도록 반환 구조를 수정했습니다.
- **UI 라이프사이클 갱신 (탭 자동변경 & 텍스트 필드 채우기)**: `HomeScreen`의 `initState` 내에 `addPostFrameCallback`을 할당하고, 첫 렌더링 직후 초기 공유된 링크가 있는지 확인합니다. 존재할 경우, ViewModel 상태 최신화, TextField 업데이트(`_linkController`), 그리고 즉각적인 탭 변경(`animateTo(1)`)이 이뤄지도록 보완했습니다.

### 변경 이유
- 백그라운드나 앱 종료 상태에서 운영체제의 외부 공유 인텐트로 앱이 켜졌을 경우, Riverpod Provider가 최초 생성되며 `build()`에서 null 상태로 덮어써져 텍스트 필드에 URL이 나타나지 않던 문제를 해결하기 위함입니다.
- Stream(스트림) 청취를 통한 백그라운드 수신뿐만 아니라, 앱 초기 로딩 완료 시점에 정확히 링크가 "링크로 가져오기" 탭에 삽입되길 원한다는 사용자(UX)의 피드백을 반영했습니다.

### 실행 순서
1. `main.dart` 파일 내 `initialSharedText` 변수를 전역화 및 `build()` 연동
2. `main.dart` 의 `ProviderScope` 의 `overrideWith` 로직 제거
3. `home_screen.dart` 의 `initState` 에 첫 프레임 렌더 후 상태 점검 및 TextField 세팅 로직 추가
4. 정상 동작 여부 검증용 `flutter analyze` 실행

### 수정 혹은 추가된 파일 경로
- `/lib/main.dart`
- `/lib/feature/home/presentation/widgets/home_screen.dart`
- `/docs/WORKLOG.md`

### 검증 방법
- 앱을 완전히 종료 후 모의로 URL 외부 공유 인텐트를 전송하여 앱을 실행시켰을 때, 즉시 `링크로 가져오기` 탭으로 전환되며 TextField 에 들어온 링크가 삽입되어 있는지 확인합니다.

---

## 2026-03-09 (receive_sharing_intent 를 flutter_sharing_intent 로 교체)

### 변경 사항
- **공유 인텐트 라이브러리 교체**: `pubspec.yaml`에서 기존 `receive_sharing_intent` 패키지를 제거하고 `flutter_sharing_intent`로 대체했습니다.
- **안드로이드 설정 변경**: `flutter_sharing_intent`의 권장 설정에 따라 `AndroidManifest.xml` 내 MainActivity의 `android:launchMode`를 `singleTop`에서 `singleTask`로 변경했습니다.
- **Dart 수신 로직 수정**: `main.dart` 내부의 공유 인텐트 수신 API를 `FlutterSharingIntent` 클래스와 `SharedFile` 모델을 사용하도록 변경하고, 텍스트와 URL 데이터의 값을 가져오는 속성을 `path`에서 `value`로 수정했습니다.

### 변경 이유
- 사용자의 라이브러리 교체 요청(`receive_sharing_intent` -> `flutter_sharing_intent`)에 따라 지정된 패키지로 외부 공유 데이터를 수신하도록 마이그레이션하기 위함입니다.

### 실행 순서
1. `flutter pub remove receive_sharing_intent` 및 `flutter pub add flutter_sharing_intent` 명령어를 실행하여 패키지 의존성을 변경했습니다.
2. `AndroidManifest.xml` 파일의 `launchMode`를 `singleTask`로 수정했습니다.
3. `main.dart`에서 `ReceiveSharingIntent` 의존성을 모두 `FlutterSharingIntent` 로 교체하고 모델 속성에 맞게 코드를 수정했습니다.
4. `flutter analyze` 검사를 통해 구문 오류가 없음을 확인했습니다.

### 수정 혹은 추가된 파일 경로
- `/pubspec.yaml`
- `/android/app/src/main/AndroidManifest.xml`
- `/lib/main.dart`
- `/docs/WORKLOG.md`

### 검증 방법
- 앱을 안드로이드 기기 또는 에뮬레이터에서 실행하고 유튜브 등 외부 앱에서 '공유' 버튼을 눌러 링크를 전달 시, 앱이 호출되고 텍스트가 정상 전달되는지 확인합니다.

---

## 2026-03-09 (외부 앱 URL 공유/수신 이벤트 연동 및 홈 탭 리다이렉션)

### 변경 사항
- **외부 인텐트 수신 설정**: 안드로이드 `AndroidManifest.xml` 파일 내 `MainActivity` 영역에 `<action android:name="android.intent.action.SEND" />`와 `text/plain` 데이터를 수신할 수 있도록 인텐트 필터를 추가했습니다. 이를 통해 유튜브나 웹 브라우저 등에서 '공유' 기능을 사용할 때 VTrace 앱이 표시됩니다.
- **수집 모듈 연동**: `receive_sharing_intent` 패키지를 추가(`pubspec.yaml`)하고 `main.dart` 내에서 백그라운드나 종료 상태에서 앱이 실행될 때의 전달된 데이터(`getInitialMedia`, `getMediaStream`)를 수신하도록 로직을 구현했습니다.
- **상태 관리 연동 및 화면 자동 갱신**: 공유된 URL 데이터를 `home_screen.dart`가 감지할 수 있도록 루트 레벨에 `NotifierProvider`(sharedTextProvider)를 두었습니다. URL이 감지되면 자동으로 `HomeViewModel`의 탭 상태를 "링크로 가져오기"로 바꾸고 입력란에 URL을 할당하도록 구현했습니다.

### 변경 이유
- 사용자가 유튜브 등에서 음원 추출 대상 영상 링크를 직접 복사하여 앱에 붙여넣는 수고를 덜고, 타 앱에서 곧바로 앱을 실행시킴과 동시에 입력 처리를 완료하여 UX(User Experience)를 향상시키기 위함입니다. 
- 복잡한 `Riverpod` 스토어와 외부 라이프사이클 이벤트 간의 상태 일치 문제를 방지하고자 루트(상위)에서 초기 이벤트를 캐치하고 `ref.listen`을 사용하여 반응형으로 처리했습니다.

### 실행 순서
1. `AndroidManifest.xml` 내 `intent-filter`에 공유 인텐트 권한을 추가했습니다.
2. `pubspec.yaml` 파일에 `receive_sharing_intent` 플러그인을 추가했습니다.
3. `home_viewmodel.dart`에 `handleSharedLink(String url)` 메소드를 구현하여 입력값을 변경하고 탭을 이동시키는 로직을 구성했습니다.
4. `main.dart`에서 `SharedTextNotifier` 전역 상태를 선언 후 수신된 인텐트 값을 업데이트하도록 설정했습니다.
5. `home_screen.dart`가 해당 상태를 `ref.listen`으로 감지 시, `TabController.animateTo`를 통해 탭을 강제 이동하고 입력창 컨트롤러의 텍스트 프로퍼티를 동기화했습니다.

### 수정 혹은 추가된 파일 경로
- `/android/app/src/main/AndroidManifest.xml`
- `/pubspec.yaml`
- `/lib/main.dart`
- `/lib/feature/home/presentation/viewmodel/home_viewmodel.dart`
- `/lib/feature/home/presentation/widgets/home_screen.dart`
- `/docs/WORKLOG.md`

---

## 2026-03-09 (공통 버튼 `VTraceButton` 로딩 상태 인터페이스 개선)

### 변경 사항
- **VTraceButton 확장**: `VTraceButton` 클래스 내부에 `isLoading` 플래그를 추가했습니다.
- **로딩 시 UI 변경**: `isLoading`이 `true`일 때 버튼의 `onPressed` 콜백을 비활성화(dim 처리 효과 달성)하고, 텍스트 대신 `CircularProgressIndicator`가 표시되도록 디자인 시스템을 리팩터링했습니다.
- **화면 적용**: 앱 내에서 `VTraceButton`을 사용하는 기존의 모든 위젯(`SignUpScreen`, `LoginScreen`, `HomeScreen`, `PayScreen`)에서 삼항 연산자를 통한 외부 프로그레스 바 래핑 로직을 제거하고, 내부 `isLoading` 파라미터 맵핑으로 대체했습니다.

### 변경 이유
- 여러 화면(회원가입, 로그인, 홈, 결제)에서 공통된 버튼 컴포넌트를 사용하고 있지만, 로딩 상태를 처리하기 위해 각 화면에서 중복된 삼항 연산 로직을 작성하고 있었습니다. 이를 `VTraceButton`으로 응집하여 코드의 가독성을 높이고 향후 디자인 시스템 유지보수를 용이하게 하기 위함입니다.

### 실행 순서
1. `vtrace_button.dart` 내부에 `isLoading` 변수를 추가하고 `build()`에 프로그레스 바 렌더링 조건을 반영했습니다.
2. `pay_screen.dart`, `home_screen.dart`, `signup_screen.dart`, `login_screen.dart`에서 `VTraceButton` 외부를 감쌌던 조건문(`isLoading ? ... : VTraceButton()`)을 제거하고 `isLoading: ...` 인자를 주입했습니다.
3. 린트(flutter analyze) 및 포맷터(dart format) 검사를 통해 구문 오류가 없음을 확인했습니다.

### 수정 혹은 추가된 파일 경로
- `/lib/core/design_system/widgets/vtrace_button.dart`
- `/lib/feature/pay/presentation/widgets/pay_screen.dart`
- `/lib/feature/home/presentation/widgets/home_screen.dart`
- `/lib/feature/auth/presentation/widgets/signup_screen.dart`
- `/lib/feature/auth/presentation/widgets/login_screen.dart`
- `/docs/WORKLOG.md`
 
---

## 2026-03-09 (인앱 결제 화면 및 로직 기본 뼈대 연동)

### 변경 사항
- **패키지 추가**: `pubspec.yaml`에 `in_app_purchase`를 도입했습니다.
- **결제 라우트 설정**: `app_router.dart`에 `/pay` 라우트를 신설하고, 홈 화면의 상단 크레딧 텍스트를 터치할 경우 결제 화면으로 진입할 수 있게 연결했습니다.
- **결제 뷰모델 구축**: `PayViewModel`과 `PayState`를 새롭게 추가해 결제 스트림(`purchaseStream`) 구독 및 결제 상품(`selectedProductId`) 선택 상태를 중앙에서 제어하도록 설계했습니다.
- **결제 UI 추가**: `PayScreen`을 생성하여 10, 35, 65 Token(각 1000, 3000, 5000원) 라디오 목록 버튼과 함께, 사용자가 구매하기 버튼(`VTraceButton`과 로딩 스피너 활용)을 누를 때 스토어 결제 창이 뜨도록 연동해 두었습니다. 

### 변경 이유
- 문서화된 클라이언트 부분 결제 MVP 기능 요구사항(`pay_requirement.md`)을 Riverpod 기반 Clean Architecture로 만족하기 위함입니다. 백엔드 검증 로직은 추후 추가될 예정이나 기기 내 결제 진입 자체는 가능하도록 Mock 연동했습니다.

### 실행 순서
1. 패키지 의존성 최신화 (`flutter pub add in_app_purchase`)
2. `pay_viewmodel.dart`를 통해 `in_app_purchase` Stream 처리 및 구매 요청 함수 구현
3. `pay_screen.dart` 추가로 상품 3개 선택할 수 있게 Radio UI 구성
4. `app_router.dart`에 Path 추가 및 `home_screen.dart`의 터치 리스너 경로 할당 (-> `/pay`)
5. Viewmodel 코드 생성기 (`build_runner`) 재호출하여 Riverpod AutoDispose 제네릭 Provider 맵핑 및 제반 에러 조치
6. `WORKLOG.md` 업데이트

### 수정 혹은 추가된 파일 경로
- `/lib/feature/pay/presentation/viewmodel/pay_viewmodel.dart` [NEW]
- `/lib/feature/pay/presentation/widgets/pay_screen.dart` [NEW]
- `/lib/router/app_router.dart`
- `/lib/feature/home/presentation/widgets/home_screen.dart`
- `/docs/WORKLOG.md`

### 검증 방법
- 홈 화면 우측 상단 텍스트(`무료 횟수 ...`)를 터치 시 팝업 아이콘과 함께 결제 상품 선택 화면으로 정상 이동하는지 확인합니다.
- `PayScreen`에서 라디오 버튼을 골라 '구매하기' 터치 시 `isAvailable()`이 실패하거나 호스팅 지연 Toast가 팝업되며 Mock 흐름이 유지되는지 체크합니다.

---

## 2026-03-09 (홈 화면 상단 크레딧 상태 표시 변경)

### 변경 사항
- **상단 크레딧 표시 텍스트 변경**: 홈 화면 우상단의 "무료 횟수" 영역에서, 남은 크레딧(`remainingCredits`)이 0일 경우 "크레딧을 추가하세요" 텍스트가 표시되도록 조건부 렌더링을 추가했습니다.
- **클릭 이벤트 선행 적용**: 향후 결제(Pay) 화면으로의 이동을 지원하기 위해 해당 텍스트를 `GestureDetector`로 감싸고, 임시 Toast 메시지를 출력하도록 변경했습니다.

### 변경 이유
- `pay_requirement.md`에 정의된 "홈 화면에서 상단 남은 Token 클릭 시 진입" 요구사항을 지원하고, 사용자가 크레딧 소진 상태를 명확히 인지하게 돕기 위함입니다.

### 실행 순서
1. `HomeScreen` AppBar `actions` 내 `Text` 위젯 조건 추가
2. 탭 이벤트 및 향후 라우팅 처리를 위해 `GestureDetector`로 래핑
3. `WORKLOG.md` 업데이트

### 수정 혹은 추가된 파일 경로
- `/lib/feature/home/presentation/widgets/home_screen.dart`
- `/docs/WORKLOG.md`

### 검증 방법
- 탭 하단의 분리 버튼 등을 이용해 잔여 크레딧이 0이 되었을 때 상단 텍스트가 "크레딧을 추가하세요"로 변경되는지 확인합니다.
- 해당 영역을 탭했을 때 임시 Toast 메시지가 제대로 표시되는지 확인합니다.

---

## 2026-03-09 (홈 화면 탭 하단 공통 분리하기 버튼 적용 및 VTraceButton 도입)

### 변경 사항
- **공통 분리 버튼 추가**: 기존 "링크로 가져오기" 탭 내부에 존재하던 "분리" 버튼을 제거하고, 탭 구조(`TabBarView`) 하단에 가로를 꽉 채우는 공통 "분리하기" 버튼을 추가했습니다. 이때 디자인 시스템 공통 위젯인 `VTraceButton`을 재사용했습니다.
- **VTraceButton 로딩 상태 추가**: `VTraceButton` 컴포넌트가 로딩 상태(`isLoading`)를 지원할 수 있도록 속성 및 UI(`CircularProgressIndicator`)를 추가 보완했습니다.
- **가져온 파일 타입 관리 변수 추가**: `home_viewmodel.dart`의 `HomeState`에 `importType` 변수(String)를 추가하여, 내 파일에서 오디오 파일을 가져왔을 때는 `'file'`, 링크 입력을 완료했을 때는 `'link'`로 타입을 지정하고 관리하도록 변경했습니다. 

### 변경 이유
- 사용자가 직관적으로 여러 방식(파일, 링크)을 통해 가져온 대상을 하단의 일관된 버튼(분리하기)을 눌러 처리할 수 있도록 UX를 개선하기 위함입니다.
- 분리 작업을 수행할 때 현재 가져온 소스의 타입(파일인지 링크인지)을 뷰모델 수준에서 명확히 구분하여 처리하기 위함입니다.

### 실행 순서
1. `HomeState`에 `importType` 변수 추가 및 기본값 정의
2. `HomeViewModel` 내의 파일 가져오기 및 링크 입력 액션 시 `importType`을 각각 `'file'`, `'link'`로 업데이트하도록 수정
3. 탭 간 이동 시 탭 상태에 맞춰 `importType` 재설정 로직 추가
4. 기존의 `separateLink` 메서드를 `separateCommon`으로 변경하여 공통 로직으로 통합
5. `HomeScreen`에 위치한 기존 탭 내부의 "분리" 버튼 제거
6. `HomeScreen` 하단(`TabBarView` 외부)에 공통 "분리하기" 버튼 추가 및 상하 패딩 8, 좌우 마진 16 적용
7. `WORKLOG.md` 에 변경 이력 추가

### 수정 혹은 추가된 파일 경로
- `/lib/feature/home/presentation/viewmodel/home_viewmodel.dart`
- `/lib/feature/home/presentation/widgets/home_screen.dart`
- `/docs/WORKLOG.md`

### 검증 방법
- 탭 하단에 "분리하기" 버튼이 가로로 꽉 차게 잘 나타나는지 확인합니다 (좌우 마진 16, 상하 패딩 8 적용).
- 1번째 탭에서 파일을 선택한 후 버튼을 눌렀을 때 분리 요청 완료 Toast 메시지가 정상적으로 보이는지 확인합니다.
- 2번째 탭에서 링크를 입력한 후 버튼을 눌렀을 때 분리 요청 완료 Toast 메시지가 정상적으로 보이는지 확인합니다.

---

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
