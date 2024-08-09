import 'package:flutter/material.dart';

// SnackBar를 표시하는 함수
void notHaveFunction(BuildContext context, {String? message}) {
  // 문자열 보간을 사용하여 메시지 문자열 생성
  final displayMessage = '${message ?? ''} 기능이 없습니다.';

  final snackBar = SnackBar(
    content: Text(
      displayMessage,
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 1),
  );

  // 스낵바 표시
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//페이지 이동 함수
void moveToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void showSnackBar(BuildContext context, {String? message}) {
  final snackBar = SnackBar(
    content: Text(
      message ?? '준비중입니다.',
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 1),
  );

  // 스낵바 표시
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
