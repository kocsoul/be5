import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:be5_cyc/pages/character.dart';
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  debugPrint("Menu button clicked");
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: DrawerApp(),
      body: const Padding(
        padding: EdgeInsets.only(left: 38.0, right: 38.0),
        child: ReceiptPage(),
      ),
    );
  }
}

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 218, 82, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // 자식 위젯을 왼쪽 정렬
            children: [
              const Text(
                '정기이용권',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 47),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                ),
                child: const SizedBox(
                  child: Text(
                    '아직 정기결제 이용권 이력이 없습니다',
                    style: TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Text('단건결제내역',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 29),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // 자식 간 균등한 간격 배치
                  children: [
                    Text(
                      '종류',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '날짜',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '금액',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 458,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 500,
                    child: const Align(
                      alignment: Alignment.center, // 중앙 정렬
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // 수평 중앙 정렬
                        children: [
                          Text(
                            '아직 단건결제 이력이 없습니다\n', // 긴 텍스트로 테스트
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center, // 텍스트 중앙 정렬
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ButtonLayout(
                buttonText: '홈으로',
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {
                  moveToPage(context, const CharacterPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
