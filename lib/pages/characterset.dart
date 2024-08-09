import 'dart:math'; // 랜덤 숫자를 생성하기 위한 라이브러리
import 'package:flutter/material.dart'; // Flutter의 Material 디자인 컴포넌트를 사용하기 위한 라이브러리
import 'package:be5_cyc/components/buttons/button_layout.dart'; // 커스텀 버튼 레이아웃 컴포넌트
import 'package:be5_cyc/components/menubar/drawer.dart'; // 커스텀 드로어 컴포넌트
import 'package:be5_cyc/pages/faceset.dart';

class CharacterSet extends StatefulWidget {
  CharacterSet({super.key});

  // 각 이미지의 경로를 저장하는 리스트
  final List<String> facePaths = [
    'assets/images/front/face/face1.png',
    'assets/images/front/face/face2.png',
    'assets/images/front/face/face3.png',
    'assets/images/front/face/face4.png',
    'assets/images/front/face/face5.png',
    'assets/images/front/face/face6.png',
    'assets/images/front/face/face7.png',
    'assets/images/front/face/face8.png',
  ];

  final List<String> eyePaths = [
    'assets/images/front/eyes/eyes1.png',
    'assets/images/front/eyes/eyes2.png',
    'assets/images/front/eyes/eyes3.png',
    'assets/images/front/eyes/eyes4.png',
    'assets/images/front/eyes/eyes5.png',
    'assets/images/front/eyes/eyes6.png',
    'assets/images/front/eyes/eyes7.png',
    'assets/images/front/eyes/eyes8.png',
  ];

  final List<String> mouthPaths = [
    'assets/images/front/mouth/mouth1.png',
    'assets/images/front/mouth/mouth2.png',
    'assets/images/front/mouth/mouth3.png',
    'assets/images/front/mouth/mouth4.png',
    'assets/images/front/mouth/mouth5.png',
    'assets/images/front/mouth/mouth6.png',
    'assets/images/front/mouth/mouth7.png',
    'assets/images/front/mouth/mouth8.png',
  ];

  final List<String> armPaths = [
    'assets/images/front/arms/arms1.png',
    'assets/images/front/arms/arms2.png',
    'assets/images/front/arms/arms3.png',
    'assets/images/front/arms/arms4.png',
    'assets/images/front/arms/arms5.png',
    'assets/images/front/arms/arms6.png',
    'assets/images/front/arms/arms7.png',
    'assets/images/front/arms/arms8.png',
  ];

  final List<String> bodyPaths = [
    'assets/images/front/body/body1.png',
    'assets/images/front/body/body2.png',
    'assets/images/front/body/body3.png',
    'assets/images/front/body/body4.png',
    'assets/images/front/body/body5.png',
    'assets/images/front/body/body6.png',
    'assets/images/front/body/body7.png',
    'assets/images/front/body/body8.png',
  ];

  @override
  State<CharacterSet> createState() => _CharacterSetState();
}

class _CharacterSetState extends State<CharacterSet> {
  // 랜덤으로 선택된 이미지 리스트를 저장하는 변수들
  late List<String> selectedFaces;

  late List<String> selectedArms;
  late List<String> selectedBodys;

  // 현재 선택된 이미지 경로를 저장하는 변수들
  String? selectedFace;
  String? selectedArm;
  String? selectedBody;

  @override
  void initState() {
    super.initState();
    selectRandomImages(); // 초기화 시 랜덤 이미지 선택
  }

  // 랜덤으로 이미지를 선택하여 리스트를 설정하는 메서드
  void selectRandomImages() {
    final random = Random();

    selectedFaces =
        (List<String>.from(widget.facePaths)..shuffle(random)).take(6).toList();
    selectedArms =
        (List<String>.from(widget.armPaths)..shuffle(random)).take(6).toList();
    selectedBodys =
        (List<String>.from(widget.bodyPaths)..shuffle(random)).take(6).toList();
  }

  // 박스가 선택되었을 때 호출되는 메서드
  void onBoxSelected(
    String bodyPath,
    String armsPath,
    String facePath,
  ) {
    setState(() {
      selectedBody = bodyPath;
      selectedArm = armsPath;
      selectedFace = facePath;
    });
  }

  // 캐릭터 부품을 표시하는 위젯
  Widget buildCharacterPart(
    String bodyPath,
    String armsPath,
    String facePath,
  ) {
    // 현재 부품이 선택된 상태인지 확인
    bool isSelected = selectedBody == bodyPath &&
        selectedArm == armsPath &&
        selectedFace == facePath;

    return GestureDetector(
      onTap: () {
        // 박스를 클릭했을 때 선택 상태로 변경
        onBoxSelected(bodyPath, armsPath, facePath);
      },
      child: Container(
        width: 140,
        height: 140,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(252, 218, 82, 1),
            width: 3, // 테두리 두께
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 각 부품 이미지 표시
            Image.asset(bodyPath, width: 100, height: 100, fit: BoxFit.cover),
            Image.asset(armsPath, width: 100, height: 100, fit: BoxFit.cover),
            Image.asset(facePath, width: 100, height: 100, fit: BoxFit.cover),
            // 선택된 상태일 때 체크 아이콘 표시
            if (isSelected)
              const Positioned(
                top: 5,
                right: 5,
                child: Icon(
                  Icons.check_circle,
                  color: Color.fromRGBO(252, 218, 82, 1),
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 각 행을 생성하는 메서드
  Widget buildRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCharacterPart(
          selectedBodys[index * 2],
          selectedArms[index * 2],
          selectedFaces[index * 2],
        ),
        buildCharacterPart(
          selectedBodys[index * 2 + 1],
          selectedArms[index * 2 + 1],
          selectedFaces[index * 2 + 1],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    debugPrint("햄버거 버튼 클릭됨");
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
      ),
      endDrawer: DrawerApp(), // 드로어 위젯
      body: Padding(
        padding: const EdgeInsets.only(
          left: 38.0,
          right: 38.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
              child: const SizedBox(
                child: Text(
                  '캐릭터 만들기',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                // 선택된 얼굴 리스트의 절반만큼 반복하여 행을 생성
                for (int i = 0; i < (selectedFaces.length / 2).floor(); i += 1)
                  buildRow(i),
              ],
            ),
            const SizedBox(height: 10),
            if (selectedBody != null &&
                selectedArm != null &&
                selectedFace != null)
              ButtonLayout(
                buttonText: '표정 제작',
                onPressed: () {
                  // 선택된 캐릭터의 이미지 경로만 전달
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Faceset(
                        selectedFace: selectedFace!,
                        selectedArm: selectedArm!,
                        selectedBody: selectedBody!,
                      ),
                    ),
                  );
                },
              ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            // '새로고침' 버튼
            ButtonLayout(
              icon: Icons.refresh,
              buttonText: '캐릭터 재생성',
              foregroundColor: Colors.red,
              border: true,
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  selectRandomImages(); // 랜덤 이미지 재선택
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
