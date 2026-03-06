# VTrace 개요
- 개발할 VTrace 앱에 대한 스켈레톤 개요

## 프로젝트 요구사항
- 앱 이름 : VTrace
- Android
  - minSdk : 26(Android 8.0)
  - targetSdk, compileSdk : 36
- IOS
  - minimum version = 14.0
- 그 외 요구사항은 Global Rule Flutter 프로젝트에 따름
- 추후 디자인을 수정할 것이니, 처음 생성은 Material 3 를 사용한다.

## 폴더 트리
- Global Rule Flutter 에 따름

## 특징
- 이 앱은 소규모 앱으로서 DataSource 계층을 사용하지 않는다.
  DataSource 가 담당하는 역할(API 응답 검증, DTO 생성 등)은 Repository 에서 직접 수행한다.
구조 규칙 :
- ApiService : HTTP 호출만 담당
- Repository:
  - ApiService 호출
  - HTTP 응답 성공 / 실패 검증
  - 실패 시 Exception Throw
  - DTO -> Domain Model mapping 수행