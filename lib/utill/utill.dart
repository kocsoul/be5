import 'package:flutter/material.dart';

// SnackBar를 표시하는 함수
void showCustomSnackBar(BuildContext context) {
  const snackBar = SnackBar(
    content: Text(
      '아직 기능이 없습니다.',
      style: TextStyle(color: Colors.white),
    ), // 메시지만 포함
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
