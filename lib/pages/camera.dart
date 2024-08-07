import 'package:be5_cyc/components/buttons/button_layout.dart';
import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'capture.dart'; // Capture 페이지 import
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  Future<void>? _initializeControllerFuture;
  bool _isTakingPicture = false; // 사진 촬영 중 상태를 추적하기 위한 변수
  String _imagePath = '';
  bool _isFlipped = false; // 카메라 좌우반전 상태를 추적하는 변수

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    // 전면 카메라 찾기
    CameraDescription? frontCamera;
    for (var camera in cameras!) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }
    if (frontCamera != null) {
      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });

      // 이미지 경로를 Capture 페이지로 전달
      if (!mounted) return;
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Capture(imagePath: _imagePath),
          ),
        );
      }
    } else {}
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_isTakingPicture) return;

    setState(() {
      _isTakingPicture = true;
    });

    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      debugPrint('사진 찍음: ${image.path}');

      // 페이지 탐색
      if (!mounted) return;
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Capture(imagePath: image.path),
          ),
        );
      }
    } catch (e) {
      debugPrint('사진 찍기 오류: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isTakingPicture = false;
        });
      }
    }
  }

  // 카메라 좌우반전 상태를 변경하는 함수
  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  debugPrint("햄버거 버튼 클릭됨");
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: DrawerApp(),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 텍스트, 카메라 프리뷰, 버튼을 포함하는 Column
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16), // 텍스트와 Stack 사이의 간격
                const Text(
                  '정면을 보고 초록색 프레임에 얼굴이 들어가게\n사진을 찍어주세요!',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16), // 텍스트와 카메라 프리뷰 사이의 간격
                // SizedBox를 사용하여 카메라 프리뷰와 버튼이 들어갈 공간 설정
                SizedBox(
                  width: 400, // 전체 Box의 너비
                  height: 400, // 전체 Box의 높이
                  child: Stack(
                    children: [
                      ClipRect(
                        child: SizedBox(
                          width: 400, // 카메라 프리뷰의 너비
                          height: 400, // 카메라 프리뷰의 높이
                          child: OverflowBox(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..rotateY(_isFlipped
                                        ? 3.1415927
                                        : 0), // 좌우반전 효과 적용
                                  child: CameraPreview(_controller!),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Positioned를 사용하여 버튼을 오른쪽 하단에 배치
                      Positioned(
                        bottom: 10, // 아래쪽에서 10의 간격
                        right: 10, // 오른쪽에서 10의 간격
                        child: ButtonLayout(
                          icon: Icons.flip,
                          onPressed: _toggleFlip, // 버튼 클릭 시 카메라 좌우반전 상태 변경
                          width: 50,
                          height: 50,
                          radius: 15,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16), // 카메라 프리뷰와 버튼 사이의 간격
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 버튼을 가운데 정렬
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ButtonLayout(
                        icon: Icons.crop_original,
                        width: 50,
                        height: 50,
                        radius: 15,
                        backgroundColor: Colors.grey,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _pickImage();
                        },
                      ),
                    ),
                    const SizedBox(width: 25), // 버튼 사이의 간격
                    Column(
                      children: [
                        const Text('촬영하기'),
                        ButtonLayout(
                          width: 55,
                          border: true,
                          borderColor: const Color.fromRGBO(252, 218, 82, 1),
                          borderWidth: 3.0,
                          backgroundColor: Colors.white,
                          onPressed: () {
                            _takePicture();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
