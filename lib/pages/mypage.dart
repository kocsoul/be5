import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus all text fields when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드가 나타나도 레이아웃 변경되지 않도록 설정
        // extendBodyBehindAppBar: true, // 앱 바 뒤로 화면이 확장되도록 설정
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
          padding: EdgeInsets.only(left: 38.0, right: 38.0),
          child: ProfileForm(),
        ),
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  ProfileFormState createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isSubscribed = false; // New state variable for checkbox

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void submitForm() {
    String nickname = _nicknameController.text;
    String email = _emailController.text;

    // Check if at least one field is filled and checkbox is checked
    if ((nickname.isEmpty && email.isEmpty) ||
        (!_formKey.currentState!.validate()) ||
        !_isSubscribed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('닉네임이나 이메일 중 하나를 입력해야 하며, 이벤트 수신동의 체크박스를 체크해야 합니다.')),
      );
      return;
    }

    // 사용자 프로필을 업데이트하는 로직 추가
    // 예: 네트워크 요청을 통해 백엔드에서 프로필 업데이트

    // Display modal dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            '수정 완료',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 70.0),
            child: Text(
              '수정이 완료되었습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19),
            ),
          ),
          actions: [
            ButtonLayout(
              buttonText: '닫기',
              onPressed: () {
                // Clear focus and close dialog
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        );
      },
    );
  }

  void cancelPayment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            '정기결제 취소',
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w900, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          content: const Padding(
              padding: EdgeInsets.symmetric(vertical: 70.0),
              child: Text(
                '정기결제를 취소하시겠습니까?\n취소하시면 다음 이용권부터\n결제가 취소됩니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19),
              )),
          actions: [
            ButtonLayout(
              buttonText: '결제 취소',
              foregroundColor: Colors.red,
              backgroundColor: Colors.white,
              border: true,
              onPressed: () {
                // Clear focus and close dialog
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 10),
            ButtonLayout(
              buttonText: '닫기',
              onPressed: () {
                // Clear focus and close dialog
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            '회원 탈퇴',
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w900, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          content: const Padding(
              padding: EdgeInsets.symmetric(vertical: 70.0),
              child: Text(
                '회원을 탈퇴하시겠습니까?\n회원을 탈퇴하시면\n이전 정보는 사라지고\n복구할 수 없습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19),
              )),
          actions: [
            ButtonLayout(
              buttonText: '회원 탈퇴',
              foregroundColor: Colors.red,
              backgroundColor: Colors.white,
              border: true,
              onPressed: () {
                // Clear focus and close dialog
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 10),
            ButtonLayout(
              buttonText: '닫기',
              onPressed: () {
                // Clear focus and close dialog
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nicknameController,
            decoration: const InputDecoration(labelText: '닉네임'),
            validator: (value) {
              // Ensure that nickname is valid only if it is not empty
              if (value != null && value.isNotEmpty && value.length < 3) {
                return '닉네임은 3글자 이상이어야 합니다.';
              }
              return null;
            },
          ),
          const SizedBox(height: 50),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: '이메일'),
            validator: (value) {
              // Ensure that email is valid only if it is not empty
              if (value != null && value.isNotEmpty) {
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return '유효한 이메일 주소를 입력해주세요';
                }
              }
              return null;
            },
          ),
          CheckboxListTile(
            title: const Text(
              '광고 및 이벤트 수신에 동의합니다.',
              style: TextStyle(fontSize: 15),
            ),
            value: _isSubscribed,
            onChanged: (bool? value) {
              setState(() {
                _isSubscribed = value ?? false;
              });
            },
            activeColor:
                const Color.fromRGBO(252, 218, 82, 1), // 선택된 상태의 체크박스 색상
            checkColor: Colors.black, // 체크박스 내부 체크 표시 색상
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero, // 여백 조정
          ),
          const SizedBox(height: 50),
          ButtonLayout(
            buttonText: '수정하기',
            onPressed: () {
              submitForm(); // 수정하기 버튼을 눌렀을 때 폼 제출
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonLayout(
            buttonText: '정기결제 취소하기',
            backgroundColor: Colors.white,
            border: true,
            onPressed: () {
              // 정기결제 취소 로직 추가
              cancelPayment();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonLayout(
            buttonText: '회원탈퇴',
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            border: true,
            onPressed: () {
              // 회원탈퇴 로직 추가
              deleteMember();
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyPage(),
  ));
}
