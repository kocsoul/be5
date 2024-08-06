import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              Container(
                margin: const EdgeInsets.only(
                    top: 10.0), // Use margin instead of padding
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(35.0), // Match button radius
                  child: Image.asset(
                    'assets/images/login/kakao.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context)
                        .size
                        .width, // Make the image cover the entire button
                    height: 53,
                    // Adjust height as needed
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 10.0), // Use margin instead of padding
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(30.0), // Match button radius
                  child: Image.asset(
                    'assets/images/login/google.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context)
                        .size
                        .width, // Make the image cover the entire button
                    height: 53,
                    // Adjust height as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
