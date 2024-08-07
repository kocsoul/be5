import 'dart:io';
import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:be5_cyc/pages/camera.dart';
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class Capture extends StatelessWidget {
  final String imagePath;

  const Capture({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  debugPrint("햄버거 버튼 클릭됨");
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: DrawerApp(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath.isNotEmpty)
            ClipRect(
              child: SizedBox(
                width: 400,
                height: 400, // 원하는 높이 설정
                child: OverflowBox(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                        child: Image.file(File(imagePath)), // 캡처한 이미지 표시
                      ),
                    ),
                  ),
                ),
              ),
            ), // 이미지 경로가 비어있지 않으면 표시

          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                ButtonLayout(buttonText: '결과보기', onPressed: () {}),
                const SizedBox(height: 20),
                ButtonLayout(
                  buttonText: '다시 촬영하기',
                  onPressed: () {
                    moveToPage(context, const CameraPage());
                  },
                  backgroundColor: Colors.white,
                  border: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
