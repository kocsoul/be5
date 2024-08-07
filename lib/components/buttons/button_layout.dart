import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class ButtonLayout extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool? border;

  const ButtonLayout({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor = const Color.fromRGBO(252, 218, 82, 1),
    this.foregroundColor = Colors.black,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ??
            MediaQuery.of(context).size.width -
                38, // null 병합연산자 -> a ?? b -> a가 있으면 a, a가 null이면 b
        height: height ?? 53.0,
        child: ElevatedButton(
          onPressed: onPressed ?? () => showCustomSnackBar(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: (border ?? false)
                  ? const BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    )
                  : BorderSide.none,
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
