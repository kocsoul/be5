import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key}); // 'const'는 StatefulWidget에서도 사용 가능

  @override
  IntroState createState() => IntroState();
}

class IntroState extends State<Intro> {
  final PageController _pageController = PageController(initialPage: 0);

  // 현재 페이지를 추적하기 위한 변수
  int _currentPage = 0;

  // 슬라이더에 사용할 이미지 목록
  final List<String> _images = [
    'assets/images/intro/phone.png',
    'assets/images/intro/phone.png',
    'assets/images/intro/phone.png',
    // 필요한 만큼 이미지 추가
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
        // 전체 위젯에 여백을 추가
        padding: const EdgeInsets.only(top: 100, left: 38, right: 38),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topCenter, // 위쪽 중앙에 정렬
              child: Padding(
                padding: EdgeInsets.only(top: 16.0), // 내부 여백 추가
                child: Text(
                  // 설명 텍스트 추가
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
              alignment: Alignment.topCenter, // 위쪽 중앙에 정렬
              child: Padding(
                padding: EdgeInsets.only(top: 100.0), // 내부 여백 추가
                child: Text(
                  // 추가 설명 텍스트
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
              mainAxisAlignment: MainAxisAlignment.center, // 위젯들을 중앙에 배치
              children: [
                Expanded(
                  // 페이지 뷰의 높이를 자동으로 맞춤
                  child: PageView.builder(
                    // PageView의 페이지를 제어하기 위한 컨트롤러
                    controller: _pageController,
                    // 페이지 변경 시 실행되는 콜백
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page; // 현재 페이지를 업데이트
                      });
                    },
                    // 이미지의 개수 + 1만큼 페이지를 생성 (마지막 페이지에 버튼 추가)
                    itemCount: _images.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _images.length) {
                        return Padding(
                          // 각 이미지에 수직 여백을 추가
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Align(
                            alignment: Alignment.topCenter, // 이미지의 정렬을 위쪽 중앙으로
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 150.0,
                                bottom: 50.0,
                              ), // 이미지 위아래 여백 추가
                              child: Image.asset(_images[index]), // 애셋에서 이미지 로드
                            ),
                          ),
                        );
                      } else {
                        // 마지막 페이지에 버튼 추가
                        return Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // 버튼을 눌렀을 때 수행할 동작
                              // 예를 들어, 다음 페이지로 이동
                            },
                            child: const Text('시작하기'),
                          ),
                        );
                      }
                    },
                  ),
                ),
                // 페이지 인디케이터 추가
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _images.length + 1, // 버튼 페이지를 위한 추가 인디케이터
                      (index) => Container(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
