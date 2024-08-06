import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/pages/login.dart';
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class IntroStart extends StatelessWidget {
  const IntroStart({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonLayout(
      buttonText: '시작하기',
      onPressed: () {
        moveToPage(context, const Login());
      },
    );
  }
}
