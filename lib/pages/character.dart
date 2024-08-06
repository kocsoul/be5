import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class Character extends StatelessWidget {
  const Character({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 비활성화
        actions: <Widget>[
          Builder(
            // Builder 위젯 사용
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu), // 햄버거 아이콘
                onPressed: () {
                  // 여기에 로그 추가
                  debugPrint("햄버거 버튼 클릭됨");
                  Scaffold.of(context).openEndDrawer(); // 오른쪽 드로어 열기
                },
              );
            },
          ),
        ],
      ),
      endDrawer: DrawerApp(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.37,
                  left: 0,
                  right: 0,
                  child: ButtonLayout(
                    buttonText: '촬영하기',
                    onPressed: () {
                      debugPrint("촬영하기 버튼 클릭됨");
                      showCustomSnackBar(context, message: '카메라');
                    },
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  left: 0,
                  right: 0,
                  child: ButtonLayout(
                    buttonText: '보관함',
                    backgroundColor: Colors.white,
                    border: true,
                    onPressed: () {
                      debugPrint("보관함 버튼 클릭됨");
                      showCustomSnackBar(context, message: '보관함');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
