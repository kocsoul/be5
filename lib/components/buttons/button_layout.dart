import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class ButtonLayout extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool? border;
  final Color? borderColor;
  final double? borderWidth;
  final IconData? icon; // New parameter for the icon
  final double? radius;
  final EdgeInsetsGeometry? padding;

  const ButtonLayout(
      {super.key,
      this.buttonText,
      this.onPressed,
      this.width,
      this.height,
      this.backgroundColor = const Color.fromRGBO(252, 218, 82, 1),
      this.foregroundColor = Colors.black,
      this.border,
      this.borderColor,
      this.borderWidth,
      this.icon,
      this.radius,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width - 38,
        height: height ?? 53.0,
        child: ElevatedButton(
          onPressed: onPressed ?? () => notHaveFunction(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 50.0),
              side: (border ?? false)
                  ? BorderSide(
                      color: borderColor ?? Colors.black,
                      width: borderWidth ?? 0.5,
                    )
                  : BorderSide.none,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Text(
                  String.fromCharCode(icon!.codePoint),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900, // Apply icon weight
                    fontFamily: icon!.fontFamily,
                  ),
                ),
              if (icon != null && buttonText != null) const SizedBox(width: 8),
              if (buttonText != null)
                Text(
                  buttonText!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
