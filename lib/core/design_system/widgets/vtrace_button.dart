import 'package:flutter/material.dart';

/// 앱 전반에서 공통으로 사용되는 프라이머리 버튼입니다.
///
/// VTrace 디자인 시스템의 주 동작(로그인, 회원가입 등) 액션 역할을 수행합니다.
class VTraceButton extends StatelessWidget {
  /// 버튼 라벨
  final String text;

  /// 버튼 클릭 콜백 (null일 경우 버튼 비활성화)
  final VoidCallback? onPressed;

  /// [VTraceButton] 객체를 생성합니다.
  const VTraceButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
