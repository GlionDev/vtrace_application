/// 오디오 분리 처리 외부 호출을 추상화한 데이터소스입니다.
abstract class AudioRemoteDataSource {
  /// 파일 경로 기반 분리 요청을 수행합니다.
  ///
  /// [path] 분리할 오디오 파일 경로
  /// 반환값은 처리 성공 여부입니다.
  Future<bool> separateFromFile({required String path});

  /// 링크 기반 분리 요청을 수행합니다.
  ///
  /// [url] 분리할 오디오 링크 URL
  /// 반환값은 처리 성공 여부입니다.
  Future<bool> separateFromLink({required String url});
}
