import 'package:flutter/material.dart';

/// 앱 전반에서 공통으로 사용되는 커스텀 텍스트 필드 컨테이너입니다.
///
/// VTrace 디자인 시스템에 맞춰 성공(초록 V) 및 실패(붉은 테두리 및 에러 메시지) 상태를 표현합니다.
class VTraceTextField extends StatelessWidget {
  /// 텍스트 필드 상단에 표시될 라벨 (null이면 표시 안 함)
  final String? label;

  /// 상태 변경을 지원하는 컨트롤러
  final TextEditingController controller;

  /// 텍스트 필드의 힌트 텍스트
  final String hintText;

  /// 에러 상태일 경우 표시할 텍스트. (null이면 에러 없음)
  final String? errorText;

  /// 조건에 일치하여 성공 상태인지 여부 (true면 우측 초록 V 아이콘 표시)
  final bool isSuccess;

  /// 비밀번호 입력과 같이 텍스트를 숨겨야 하는지 여부
  final bool obscureText;

  /// 텍스트 변경 이벤트 리스너
  final ValueChanged<String>? onChanged;

  /// [VTraceTextField] 객체를 생성합니다.
  const VTraceTextField({
    super.key,
    this.label,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.isSuccess = false,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            // 에러 상태일 때 커스텀 붉은 테두리
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? Colors.red : Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? Colors.red : Theme.of(context).primaryColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            // 우측 상태 아이콘 표시 (성공 조건인 경우)
            suffixIcon: isSuccess && !hasError
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
