import 'package:be5_cyc/components/menubar/drawer.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  Future<void>? _initializeControllerFuture;

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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
                const Text(
                  '정면을 보고 초록색 프레임에 얼굴이 들어가게\n사진을 찍어주세요!',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16), // 텍스트와 카메라 프리뷰 사이의 간격
                ClipRect(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 400, // 원하는 높이 설정
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height, //
                          child: CameraPreview(_controller!),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // 카메라 프리뷰와 버튼 사이의 간격
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 버튼을 가운데 정렬
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await _initializeControllerFuture;
                          final image = await _controller!.takePicture();
                          debugPrint('사진 찍음: ${image.path}');
                        } catch (e) {
                          debugPrint('사진 찍기 오류: $e');
                        }
                      },
                      child: const Text('사진추가'),
                    ),
                    const SizedBox(width: 16), // 버튼 사이의 간격
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await _initializeControllerFuture;
                          final image = await _controller!.takePicture();
                          debugPrint('사진 찍음: ${image.path}');
                        } catch (e) {
                          debugPrint('사진 찍기 오류: $e');
                        }
                      },
                      child: const Text('촬영하기'),
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
