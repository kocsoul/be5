import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  DrawerApp({super.key});

  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.mode_edit, 'title': '개인정보수정'},
    {'icon': Icons.camera_alt, 'title': '촬영하기'},
    {'icon': Icons.vertical_align_bottom, 'title': '보관함'},
    {'icon': Icons.receipt, 'title': '결제이력'},
    {'icon': Icons.exit_to_app, 'title': '로그아웃'},
  ];

  @override
  Widget build(BuildContext context) {
    const Divider(
      color: Colors.grey, // 경계선 색상
      thickness: 1.0, // 경계선 두께
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // 드로어 너비 설정
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle, // 사각형 모양 설정
        borderRadius: BorderRadius.zero, // 모서리를 둥글게 하지 않음
      ),
      child: Drawer(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 120.0, left: 20.0, right: 20.0),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  // leading: Icon(menuItems[index]['icon']),
                  title: Text(menuItems[index]['title']),
                  onTap: () {
                    showCustomSnackBar(context,
                        message: menuItems[index]['title']);
                    Navigator.pop(context); // 드로어 닫기
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
