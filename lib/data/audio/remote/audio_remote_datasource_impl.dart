import 'audio_remote_datasource.dart';

/// [AudioRemoteDataSource] 의 mock 구현체입니다.
///
/// 추후 백엔드 API 명세 확정 시 본 클래스의 호출 본문을 그에 맞춰 교체합니다.
class AudioRemoteDataSourceImpl implements AudioRemoteDataSource {
  /// [AudioRemoteDataSourceImpl] 객체를 생성합니다.
  const AudioRemoteDataSourceImpl();

  @override
  Future<bool> separateFromFile({required String path}) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<bool> separateFromLink({required String url}) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
