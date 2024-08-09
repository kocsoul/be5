import 'package:be5_cyc/pages/character.dart';
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Set background color for the entire screen
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Handle your onPressed logic here
                  showSnackBar(context, message: '카카오로그인');
                  // You can navigate to another screen, show a dialog, etc.
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 10.0), // Use margin instead of padding
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(35.0), // Match button radius
                    child: Image.asset(
                      'assets/images/login/kakao.png',
                      fit: BoxFit.cover,
                      width: 354.5, // Make the image cover the entire button
                      height: 53,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showSnackBar(context, message: '구글로그인');
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 20.0), // Use margin instead of padding
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(30.0), // Match button radius
                    child: Image.asset(
                      'assets/images/login/google.png',
                      fit: BoxFit.cover,
                      width: 354.5, // Make the image cover the entire button
                      height: 53,
                      // Adjust height as needed
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  moveToPage(context, const CharacterPage());
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: const Text('로그인 건너뛰기'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
