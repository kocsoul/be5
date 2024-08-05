import 'package:be5_cyc/components/buttons/snackbar.dart';
import 'package:flutter/material.dart';

class ButtonLayout extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double width; // MediaQuery와 일관성을 유지하기 위해 num 대신 double 사용
  final Color backgroundColor;
  final Color foregroundColor;

  const ButtonLayout({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.width = 10.0, // 기본 너비 오프셋
    this.backgroundColor = const Color.fromRGBO(252, 218, 82, 1),
    this.foregroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - width, // 너비 오프셋 사용
        child: ElevatedButton(
          onPressed: onPressed ?? () => showCustomSnackBar(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor, // 전달받은 배경색 사용
            foregroundColor: foregroundColor, // 전달받은 전경색 사용
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0), // 둥근 모서리
            ),
          ),
          child: Text(
            buttonText, // 전달받은 버튼 텍스트 사용
            style: const TextStyle(
              fontSize: 20, // 폰트 크기
              fontWeight: FontWeight.w300, // 폰트 굵기
            ),
          ),
        ),
      ),
    );
  }
}
