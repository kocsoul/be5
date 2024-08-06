import 'package:be5_cyc/components/buttons/intro_start.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  IntroState createState() => IntroState();
}

class IntroState extends State<Intro> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  final List<String> _images = [
    'assets/images/intro/phone.png',
    'assets/images/intro/phone.png',
    'assets/images/intro/phone.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 38, right: 38),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  '사진을 넣으면\n나와 닮은 캐릭터가 뚝딱',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Text(
                  '나만의 캐릭터로 굿즈도 만들고 이모티콘도 만들어요',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _images.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _images.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 150.0,
                                bottom: 50.0,
                              ),
                              child: Image.asset(_images[index]),
                            ),
                          ),
                        );
                      } else {
                        return const IntroStart();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _images.length + 1,
                      (index) => GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentPage == index ? 12.0 : 8.0,
                          height: _currentPage == index ? 12.0 : 8.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
