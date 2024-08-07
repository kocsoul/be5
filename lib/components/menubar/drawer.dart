import 'package:be5_cyc/pages/camera.dart';
import 'package:be5_cyc/pages/my_character.dart';
import 'package:be5_cyc/pages/mypage.dart';
// import 'package:be5_cyc/pages/edit_profile.dart'; // EditProfilePage 파일 추가
// import 'package:be5_cyc/pages/storage.dart'; // StoragePage 파일 추가
// import 'package:be5_cyc/pages/payment_history.dart'; // PaymentHistoryPage 파일 추가
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  DrawerApp({super.key});

  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.mode_edit,
      'title': '개인정보수정',
      'page': 'EditProfilePage', // 문자열로 페이지 이름
    },
    {
      'icon': Icons.camera_alt,
      'title': '촬영하기',
      'page': 'CameraPage',
    },
    {
      'icon': Icons.vertical_align_bottom,
      'title': '보관함',
      'page': 'StoragePage',
    },
    {
      'icon': Icons.receipt,
      'title': '결제이력',
      'page': 'PaymentHistoryPage',
    },
    {
      'icon': Icons.exit_to_app,
      'title': '로그아웃',
      'page': null,
    },
  ];

  void _handleLogout(BuildContext context) {
    // 로그아웃 로직 구현
    showCustomSnackBar(context, message: "로그아웃되었습니다.");
    // 추가적인 로그아웃 처리가 필요하면 여기에 작성
  }

  // 페이지 이름에 따라 페이지를 반환하는 메서드
  Widget _getPageByName(String pageName) {
    switch (pageName) {
      case 'EditProfilePage':
        return const MyPage(); // CameraPage의 인스턴스를 반환
      case 'CameraPage':
        return const CameraPage(); // CameraPage의 인스턴스를 반환
      case 'StoragePage':
        return const MyCharacter(); // CameraPage의 인스턴스를 반환
      case 'PaymentHistoryPage':
        return const CameraPage(); // CameraPage의 인스턴스를 반환
      default:
        return Container(); // 기본 빈 페이지 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // 드로어 너비 설정
      decoration: const BoxDecoration(
        color: Color.fromRGBO(252, 218, 82, 1),
        shape: BoxShape.rectangle, // 사각형 모양 설정
        borderRadius: BorderRadius.zero, // 모서리를 둥글게 하지 않음
      ),
      child: Drawer(
        backgroundColor: const Color.fromRGBO(252, 218, 82, 1),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 120.0, left: 20.0, right: 20.0),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: Icon(menuItems[index]['icon']), // 아이콘 추가
                  title: Text(menuItems[index]['title']),
                  onTap: () {
                    // 페이지로 이동
                    if (menuItems[index]['page'] != null) {
                      Navigator.pop(context); // 드로어 닫기
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              _getPageByName(menuItems[index]['page']),
                        ),
                      );
                    } else if (menuItems[index]['title'] == '로그아웃') {
                      // 로그아웃 처리
                      _handleLogout(context);
                    }
                  },
                ),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
