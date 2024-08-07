import 'dart:io';
import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:be5_cyc/pages/camera.dart';
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class Capture extends StatefulWidget {
  final String imagePath;

  const Capture({super.key, required this.imagePath});

  @override
  _CaptureState createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  bool _isFlipped = false; // 이미지 좌우반전 상태를 추적하는 변수

  // 이미지 좌우반전 상태를 변경하는 함수
  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

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
          if (widget.imagePath.isNotEmpty)
            SizedBox(
              width: 400,
              height: 500, // 원하는 높이 설정
              child: Stack(
                children: [
                  ClipRect(
                    child: SizedBox(
                      width: 400,
                      height: 500,
                      child: OverflowBox(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..scale(
                                    _isFlipped ? -1.0 : 1.0, 1.0), // 좌우반전 효과 적용
                              child: Image.file(
                                  File(widget.imagePath)), // 캡처한 이미지 표시
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10, // 아래쪽에서 10의 간격
                    right: 10, // 오른쪽에서 10의 간격
                    child: ButtonLayout(
                      icon: Icons.flip,
                      onPressed: _toggleFlip, // 버튼 클릭 시 카메라 좌우반전 상태 변경
                      width: 50,
                      height: 50,
                      radius: 15,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ), // 이미지 경로가 비어있지 않으면 표시
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                ButtonLayout(
                  buttonText: '결과보기',
                  onPressed: () {},
                ),
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
