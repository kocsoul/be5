import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:be5_cyc/pages/character.dart';
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class MyCharacter extends StatelessWidget {
  const MyCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // 앱 바 배경 투명
        elevation: 0, // 앱 바 그림자 제거
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Unfocus all text fields
                  FocusScope.of(context).unfocus();
                  debugPrint("햄버거 버튼 클릭됨");
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: DrawerApp(),
      body: const Padding(
          padding: EdgeInsets.only(left: 38.0, right: 38.0), child: Storeage()),
    );
  }
}

class Storeage extends StatefulWidget {
  const Storeage({super.key});

  @override
  State<Storeage> createState() => _StoreageState();
}

class _StoreageState extends State<Storeage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // Wrap with Center widget
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
        children: [
          const Center(
            child: Text(
              '보관중인 캐릭터가 없습니다.',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonLayout(
              buttonText: '홈으로',
              backgroundColor: Colors.white,
              border: true,
              onPressed: () {
                moveToPage(context, const Character());
              })
        ],
      ),
    );
  }
}
