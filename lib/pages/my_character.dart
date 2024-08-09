import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:be5_cyc/pages/character.dart';
import 'package:be5_cyc/provider/character_provider.dart';
import 'package:be5_cyc/utill/utill.dart';

class MyCharacter extends StatefulWidget {
  const MyCharacter({super.key});

  @override
  State<MyCharacter> createState() => _MyCharacterState();
}

class _MyCharacterState extends State<MyCharacter> {
  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);
    final characters = characterProvider.characters;

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
      body: characters.isNotEmpty
          ? buildCharacterGrid(characters, characterProvider)
          : buildNoCharacterWidget(context),
    );
  }

  Widget buildCharacterGrid(
      List<Character> characters, CharacterProvider provider) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          '저장된 캐릭터',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return GestureDetector(
                onTap: () =>
                    showDeleteDialog(context, provider, character, index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(252, 218, 82, 1),
                            width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            Image.asset(character.body, fit: BoxFit.cover),
                            Image.asset(character.arm, fit: BoxFit.cover),
                            Image.asset(character.face, fit: BoxFit.cover),
                            Image.asset(character.eye, fit: BoxFit.cover),
                            Image.asset(character.mouth, fit: BoxFit.cover),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void showDeleteDialog(BuildContext context, CharacterProvider provider,
      Character character, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('삭제 확인'),
          content: const Text('이 캐릭터를 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('삭제'),
              onPressed: () {
                provider.removeCharacter(index);
                Navigator.of(context).pop();
                setState(() {}); // UI 갱신
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildNoCharacterWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '보관중인 캐릭터가 없습니다.',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        ButtonLayout(
          buttonText: '홈으로',
          backgroundColor: Colors.white,
          border: true,
          onPressed: () => moveToPage(context, const CharacterPage()),
        ),
      ],
    );
  }
}
