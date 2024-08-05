import 'package:be5_cyc/pages/intro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // 기본 스캐폴드 배경색 설정
      ),
      home: FutureBuilder<bool>(
        future: getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Future가 완료될 때까지 로딩 표시기를 보여줍니다.
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            // 에러가 발생했을 때 처리합니다.
            return const Scaffold(
              body: Center(child: Text('오류가 발생했습니다.')),
            );
          } else {
            // 사용자 정보가 있는 경우와 없는 경우에 따라 다른 페이지를 반환합니다.
            if (snapshot.data == true) {
              return const Apage();
            } else {
              return const Intro();
            }
          }
        },
      ),
    );
  }
}

// 사용자 정보를 가져오는 함수
Future<bool> getUserInfo() async {
  // 네트워크 호출 또는 데이터베이스 조회를 시뮬레이션합니다.
  await Future.delayed(const Duration(seconds: 2));

  // 사용자 정보가 있는지를 확인하는 로직을 여기에 추가합니다.
  bool userInfoAvailable = false; // 사용자 정보가 있을 경우 true, 없으면 false로 설정합니다.
  return userInfoAvailable;
}

// A 페이지
class Apage extends StatelessWidget {
  const Apage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('B 페이지')),
      body: const Center(child: Text('B 페이지에 오신 것을 환영합니다')),
    );
  }
}
