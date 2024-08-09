import 'package:be5_cyc/pages/intro.dart';
import 'package:be5_cyc/provider/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 메인 함수
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
        // 다른 프로바이더가 필요하면 여기에 추가합니다.
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '통합된 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder<bool>(
        future: getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('오류가 발생했습니다.')),
            );
          } else {
            if (snapshot.data == true) {
              return const Apage(); // 사용자 정보가 있으면 Apage로 이동
            } else {
              return const Intro(); // 사용자 정보가 없으면 Intro로 이동
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
      appBar: AppBar(title: const Text('A 페이지')), // 제목을 A 페이지로 수정
      body: const Center(child: Text('A 페이지에 오신 것을 환영합니다')), // 본문도 A 페이지로 수정
    );
  }
}
