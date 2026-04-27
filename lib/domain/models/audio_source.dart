/// 오디오 분리 작업의 입력 소스 종류를 나타냅니다.
enum AudioSourceType {
  /// 기기 내 파일
  file,

  /// 외부 링크(URL)
  link,
}

/// 오디오 분리 요청에 사용할 입력 소스를 나타내는 도메인 모델입니다.
class AudioSource {
  /// 입력 소스 타입
  final AudioSourceType type;

  /// 파일 경로(file 타입일 때 사용)
  final String? filePath;

  /// 링크 URL(link 타입일 때 사용)
  final String? linkUrl;

  /// [AudioSource] 객체를 생성합니다.
  ///
  /// [type] 소스 타입
  /// [filePath] 파일 경로
  /// [linkUrl] 링크 URL
  const AudioSource({required this.type, this.filePath, this.linkUrl});

  /// 파일 기반 [AudioSource] 를 생성합니다.
  ///
  /// [path] 선택된 파일의 경로
  /// 반환값은 file 타입의 [AudioSource] 객체입니다.
  factory AudioSource.fromFile(String path) =>
      AudioSource(type: AudioSourceType.file, filePath: path);

  /// 링크 기반 [AudioSource] 를 생성합니다.
  ///
  /// [url] 입력된 링크 URL
  /// 반환값은 link 타입의 [AudioSource] 객체입니다.
  factory AudioSource.fromLink(String url) =>
      AudioSource(type: AudioSourceType.link, linkUrl: url);
}
