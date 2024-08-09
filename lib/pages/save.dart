import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:be5_cyc/pages/character.dart';
import 'package:be5_cyc/pages/characterset.dart';
import 'package:be5_cyc/pages/my_character.dart';
import 'package:be5_cyc/provider/character_provider.dart'
    as provider; // Alias for provider package
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Save extends StatelessWidget {
  final String selectedFace;
  final String selectedEye;
  final String selectedMouth;
  final String selectedArm;
  final String selectedBody;

  const Save({
    super.key,
    required this.selectedFace,
    required this.selectedEye,
    required this.selectedMouth,
    required this.selectedArm,
    required this.selectedBody,
  });

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
      endDrawer: DrawerApp(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selected Character',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildCharacterImage(context),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterImage(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(252, 218, 82, 1),
              width: 3,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Image.asset(selectedBody, fit: BoxFit.cover),
                Image.asset(selectedArm, fit: BoxFit.cover),
                Image.asset(selectedFace, fit: BoxFit.cover),
                Image.asset(selectedEye, fit: BoxFit.cover),
                Image.asset(selectedMouth, fit: BoxFit.cover),
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
        ButtonLayout(
          buttonText: '저장',
          onPressed: () {
            // Save the character to the global state
            Provider.of<provider.CharacterProvider>(context, listen: false)
                .saveCharacter(
              provider.Character(
                face: selectedFace,
                eye: selectedEye,
                mouth: selectedMouth,
                arm: selectedArm,
                body: selectedBody,
              ),
            );

            // Show a confirmation popup
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    '저장완료',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                    '저장이 완료되었습니다.\n보관함으로 이동하시겠습니까?',
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    ButtonLayout(
                      buttonText: '보관함으로 이동',
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        moveToPage(context, const MyCharacter());
                      },
                    ),
                    const SizedBox(height: 20),
                    ButtonLayout(
                      buttonText: '홈으로',
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      icon: Icons.refresh,
                      border: true,
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        moveToPage(context, const CharacterPage());
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(height: 20),
        ButtonLayout(
          buttonText: '다시 만들기',
          backgroundColor: Colors.white,
          border: true,
          foregroundColor: Colors.red,
          icon: Icons.refresh,
          onPressed: () {
            moveToPage(context, CharacterSet());
          },
        ),
      ],
    );
  }
}
